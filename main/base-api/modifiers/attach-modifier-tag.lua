--- @param modifier_tag ModifierTag
--- @param modifier_evaluator ModifierEvaluator
function AttachModifierTag(modifier_evaluator, modifier_tag)
    modifier_evaluator[#modifier_evaluator + 1] = modifier_tag
    modifier_tag.disabled:bind_evaluator(modifier_evaluator)
    modifier_tag.efficiency:bind_evaluator(modifier_evaluator)
end

return AttachModifierTag