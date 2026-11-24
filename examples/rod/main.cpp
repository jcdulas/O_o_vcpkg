#include <oor/api/CardEdits.hpp>
#include <oor/api/ControlEdits.hpp>
#include <oos/api/Analyses.hpp>
#include <oos/api/ModelFromDeck.hpp>

#include <cmath>
#include <iostream>

using Field = oor::model::FieldValue;
Field integer(int value) { return {Field::Kind::Integer, value, 0., {}}; }
Field real(double value) { return {Field::Kind::Real, 0, value, {}}; }

int main()
{
    auto deck = oor::api::Deck::createModel();
    oor::api::setSolution(*deck, "LinearStatics");
    const oor::api::ControlRecord controls[] = {
        {"SinglePointConstrSelection", {"1"}}, {"DisplacementOutput", {"All"}},
        {"SubcaseStart", {"1"}}, {"StaticLoadSelection", {"2"}}
    };
    oor::api::setCaseControl(*deck, controls);
    const oor::api::CardInput cards[] = {
        {"Node", {integer(1), {}, real(0), real(0), real(0)}},
        {"Node", {integer(2), {}, real(3), real(0), real(0)}},
        {"Rod2", {integer(1), integer(1), integer(1), integer(2)}},
        {"RodProp", {integer(1), integer(1), real(2)}},
        {"IsoMat", {integer(1), real(1000), {}, real(0.3), real(1)}},
        {"SinglePointConstrList", {integer(1), integer(123456), integer(1)}},
        {"SinglePointConstrList", {integer(1), integer(23456), integer(2)}},
        {"PointForceLoad", {integer(2), integer(2), integer(0), real(10), real(1), real(0), real(0)}}
    };
    oor::api::insertCards(*deck, cards);
    deck->applyDefaults();
    const auto snapshot = oos::api::modelFromDeck(deck);
    deck.reset(); // Exercises ownership of the Arrow buffers during the solve.
    const auto result = oos::api::runAnalysis(*snapshot, oos::api::Analysis::Statics, {});
    for (const auto& table : result.tables.nodalTables)
        if (table.kind == "displacements")
            for (std::size_t row = 0; row < table.rowCount(); ++row)
                if (table.ids[row] == 2)
                {
                    const double displacement = table.values[6 * row];
                    std::cout << "Axial displacement at node 2: " << displacement << '\n';
                    return std::abs(displacement - 0.015) < 1e-12 ? 0 : 1;
                }
    std::cerr << "Missing displacement at node 2\n";
    return 1;
}
