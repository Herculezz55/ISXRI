#include "Ability.h"
#include "ExtensionTLOs.h"

#include <memory>
#include <regex>


u_long Ability::Id() const {
    const auto id = this->lsObject->GetMember("ID");
    return id.has_value() ? id->Int64 : 0;
}

bool Ability::IsReady() const {
    const auto isReady = this->lsObject->GetMember("IsReady");
    return isReady.has_value() ? isReady->Int : false;
}

float Ability::TimeUntilReady() const {
    const auto timeUntilReady = this->lsObject->GetMember("TimeUntilReady");
    return timeUntilReady.has_value() ? timeUntilReady->Float : 0.0f;
}

bool Ability::IsQueued() const {
    const auto isQueued = this->lsObject->GetMember("IsQueued");
    return isQueued.has_value() ? isQueued->Int : false;
}

bool Ability::IsAbilityInfoAvailable() const {
    const auto isAbilityInfoAvailable = this->lsObject->GetMember("IsAbilityInfoAvailable");
    return isAbilityInfoAvailable.has_value() ? isAbilityInfoAvailable->Int : false;
}

AbilityInfo Ability::GetAbilityInfo() const {
    return AbilityInfo(make_shared<LSObject>(this->lsObject->GetMember("ToAbilityInfo")));
}

ExportedAbility Ability::ToExportedAbility() const {
    auto exportedAbility = ExportedAbility();
    exportedAbility.Id = this->Id();
    exportedAbility.Name = this->GetAbilityInfo().Name();
    exportedAbility.Description = this->GetAbilityInfo().Description();
    exportedAbility.Tier = this->GetAbilityInfo().Tier();
    //logd << "SubClass: " << ExtensionTLOs::Me().SubClass() << endl;
    exportedAbility.Level = this->GetAbilityInfo().ClassByName(ExtensionTLOs::Me().SubClass()).Level();
    exportedAbility.HealthCost = this->GetAbilityInfo().HealthCost();
    exportedAbility.PowerCost = this->GetAbilityInfo().PowerCost();
    exportedAbility.DissonanceCost = this->GetAbilityInfo().DissonanceCost();
    exportedAbility.SavageryCost = this->GetAbilityInfo().SavageryCost();
    exportedAbility.ConcentrationCost = this->GetAbilityInfo().ConcentrationCost();
    exportedAbility.MainIconID = this->GetAbilityInfo().MainIconID();
    exportedAbility.HOIconID = this->GetAbilityInfo().HOIconID();
    exportedAbility.CastingTime = this->GetAbilityInfo().CastingTime();
    exportedAbility.RecoveryTime = this->GetAbilityInfo().RecoveryTime();
    exportedAbility.RecastTime = this->GetAbilityInfo().RecastTime();
    exportedAbility.MaxDuration = this->GetAbilityInfo().MaxDuration();
    exportedAbility.NumClasses = this->GetAbilityInfo().NumClasses();
    exportedAbility.NumEffects = this->GetAbilityInfo().NumEffects();
    exportedAbility.BackdropIconID = this->GetAbilityInfo().BackDropIconID();
    exportedAbility.HealthCostPerTick = this->GetAbilityInfo().HealthCostPerTick();
    exportedAbility.PowerCostPerTick = this->GetAbilityInfo().PowerCostPerTick();
    exportedAbility.DissonanceCostPerTick = this->GetAbilityInfo().DissonanceCostPerTick();
    exportedAbility.SavageryCostPerTick = this->GetAbilityInfo().SavageryCostPerTick();
    exportedAbility.MaxAOETargets = this->GetAbilityInfo().MaxAOETargets();
    exportedAbility.DoesNotExpire = this->GetAbilityInfo().DoesNotExpire();
    exportedAbility.GroupRestricted = this->GetAbilityInfo().GroupRestricted();
    exportedAbility.AllowRaid = this->GetAbilityInfo().AllowRaid();
    exportedAbility.IsBeneficial = this->GetAbilityInfo().IsBeneficial();
    exportedAbility.EffectRadius = this->GetAbilityInfo().EffectRadius();
    exportedAbility.TargetType = this->GetAbilityInfo().TargetType();
    exportedAbility.SpellBookType = this->GetAbilityInfo().SpellBookType();
    exportedAbility.MinRange = this->GetAbilityInfo().MinRange();
    exportedAbility.MaxRange = this->GetAbilityInfo().MaxRange();

    for (int idx = 1; idx < this->GetAbilityInfo().NumEffects(); ++idx) {
        exportedAbility.Effects.push_back(this->GetAbilityInfo().EffectByIndex(idx).Description());
    }

    if (RequiresStealth(exportedAbility.Effects)) {
        exportedAbility.RequirementsFlags |= AbilityRequirementsFlags::Stealth;
    }

    if (RequiresFlanking(exportedAbility.Effects)) {
        exportedAbility.RequirementsFlags |= AbilityRequirementsFlags::Flanking;
    }

    if (RequiresNonEpic(exportedAbility.Effects)) {
        exportedAbility.RequirementsFlags |= AbilityRequirementsFlags::NoEpic;
    }

    if (IsStun(exportedAbility.Effects)) {
        exportedAbility.TypeFlags |= AbilityTypeFlags::Stun;
    }

    if (IsInterrupt(exportedAbility.Effects)) {
        exportedAbility.TypeFlags |= AbilityTypeFlags::Interrupt;
    }


    return exportedAbility;
}

void Ability::Use() const {
    this->lsObject->CallMethod("Use");
}

void Ability::Examine() const {
    this->lsObject->CallMethod("Examine");
}

bool Ability::RequiresStealth(const vector<string> &effects) {
    const std::regex stealthRegex(
        "(I need to be stealthed!|You must be (in stealth|sneaking) to use this(!| ability.))");

    return std::ranges::any_of(
        effects, [&stealthRegex](const string &effect) {
            return std::regex_search(effect, stealthRegex);
        });
}

bool Ability::RequiresFlanking(const vector<string> &effects) {
    return std::ranges::any_of(effects, [](const string &effect) {
        return effect == "Must be flanking or behind";
    });
}

bool Ability::RequiresNonEpic(const vector<string> &effects) {
    return std::ranges::any_of(effects, [](const string &effect) {
        return effect == "Does not affect Epic targets";
    });
}

bool Ability::IsInterrupt(const vector<string> &effects) {
    return std::ranges::any_of(effects, [](const string &effect) {
        return effect == "Interrupts target";
    });
}

bool Ability::IsStun(const vector<string> &effects) {
    return std::ranges::any_of(effects, [](const string &effect) {
        return effect == "Stuns target";
    });
}

