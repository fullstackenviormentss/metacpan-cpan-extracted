use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/HTML/FormFu.pm',
    'lib/HTML/FormFu/Attribute.pm',
    'lib/HTML/FormFu/Constants.pm',
    'lib/HTML/FormFu/Constraint.pm',
    'lib/HTML/FormFu/Constraint/ASCII.pm',
    'lib/HTML/FormFu/Constraint/AllOrNone.pm',
    'lib/HTML/FormFu/Constraint/AutoSet.pm',
    'lib/HTML/FormFu/Constraint/Bool.pm',
    'lib/HTML/FormFu/Constraint/Callback.pm',
    'lib/HTML/FormFu/Constraint/CallbackOnce.pm',
    'lib/HTML/FormFu/Constraint/DateTime.pm',
    'lib/HTML/FormFu/Constraint/DependOn.pm',
    'lib/HTML/FormFu/Constraint/Email.pm',
    'lib/HTML/FormFu/Constraint/Equal.pm',
    'lib/HTML/FormFu/Constraint/File.pm',
    'lib/HTML/FormFu/Constraint/File/MIME.pm',
    'lib/HTML/FormFu/Constraint/File/MaxSize.pm',
    'lib/HTML/FormFu/Constraint/File/MinSize.pm',
    'lib/HTML/FormFu/Constraint/File/Size.pm',
    'lib/HTML/FormFu/Constraint/Integer.pm',
    'lib/HTML/FormFu/Constraint/JSON.pm',
    'lib/HTML/FormFu/Constraint/Length.pm',
    'lib/HTML/FormFu/Constraint/MaxLength.pm',
    'lib/HTML/FormFu/Constraint/MaxRange.pm',
    'lib/HTML/FormFu/Constraint/MinLength.pm',
    'lib/HTML/FormFu/Constraint/MinMaxFields.pm',
    'lib/HTML/FormFu/Constraint/MinRange.pm',
    'lib/HTML/FormFu/Constraint/Number.pm',
    'lib/HTML/FormFu/Constraint/Printable.pm',
    'lib/HTML/FormFu/Constraint/Range.pm',
    'lib/HTML/FormFu/Constraint/Regex.pm',
    'lib/HTML/FormFu/Constraint/Repeatable/Any.pm',
    'lib/HTML/FormFu/Constraint/Required.pm',
    'lib/HTML/FormFu/Constraint/Set.pm',
    'lib/HTML/FormFu/Constraint/SingleValue.pm',
    'lib/HTML/FormFu/Constraint/Word.pm',
    'lib/HTML/FormFu/Deflator.pm',
    'lib/HTML/FormFu/Deflator/Callback.pm',
    'lib/HTML/FormFu/Deflator/CompoundDateTime.pm',
    'lib/HTML/FormFu/Deflator/CompoundSplit.pm',
    'lib/HTML/FormFu/Deflator/FormatNumber.pm',
    'lib/HTML/FormFu/Deflator/PathClassFile.pm',
    'lib/HTML/FormFu/Deflator/Strftime.pm',
    'lib/HTML/FormFu/Deploy.pm',
    'lib/HTML/FormFu/Element.pm',
    'lib/HTML/FormFu/Element/Blank.pm',
    'lib/HTML/FormFu/Element/Block.pm',
    'lib/HTML/FormFu/Element/Button.pm',
    'lib/HTML/FormFu/Element/Checkbox.pm',
    'lib/HTML/FormFu/Element/Checkboxgroup.pm',
    'lib/HTML/FormFu/Element/ComboBox.pm',
    'lib/HTML/FormFu/Element/ContentButton.pm',
    'lib/HTML/FormFu/Element/Date.pm',
    'lib/HTML/FormFu/Element/DateTime.pm',
    'lib/HTML/FormFu/Element/Email.pm',
    'lib/HTML/FormFu/Element/Fieldset.pm',
    'lib/HTML/FormFu/Element/File.pm',
    'lib/HTML/FormFu/Element/Hidden.pm',
    'lib/HTML/FormFu/Element/Hr.pm',
    'lib/HTML/FormFu/Element/Image.pm',
    'lib/HTML/FormFu/Element/Label.pm',
    'lib/HTML/FormFu/Element/Multi.pm',
    'lib/HTML/FormFu/Element/Number.pm',
    'lib/HTML/FormFu/Element/Password.pm',
    'lib/HTML/FormFu/Element/Radio.pm',
    'lib/HTML/FormFu/Element/Radiogroup.pm',
    'lib/HTML/FormFu/Element/Repeatable.pm',
    'lib/HTML/FormFu/Element/Reset.pm',
    'lib/HTML/FormFu/Element/Select.pm',
    'lib/HTML/FormFu/Element/SimpleTable.pm',
    'lib/HTML/FormFu/Element/Src.pm',
    'lib/HTML/FormFu/Element/Submit.pm',
    'lib/HTML/FormFu/Element/Text.pm',
    'lib/HTML/FormFu/Element/Textarea.pm',
    'lib/HTML/FormFu/Element/URL.pm',
    'lib/HTML/FormFu/Exception.pm',
    'lib/HTML/FormFu/Exception/Constraint.pm',
    'lib/HTML/FormFu/Exception/Inflator.pm',
    'lib/HTML/FormFu/Exception/Input.pm',
    'lib/HTML/FormFu/Exception/Transformer.pm',
    'lib/HTML/FormFu/Exception/Validator.pm',
    'lib/HTML/FormFu/FakeQuery.pm',
    'lib/HTML/FormFu/Filter.pm',
    'lib/HTML/FormFu/Filter/Callback.pm',
    'lib/HTML/FormFu/Filter/CompoundJoin.pm',
    'lib/HTML/FormFu/Filter/CompoundSprintf.pm',
    'lib/HTML/FormFu/Filter/CopyValue.pm',
    'lib/HTML/FormFu/Filter/Encode.pm',
    'lib/HTML/FormFu/Filter/ForceListValue.pm',
    'lib/HTML/FormFu/Filter/FormatNumber.pm',
    'lib/HTML/FormFu/Filter/HTMLEscape.pm',
    'lib/HTML/FormFu/Filter/HTMLScrubber.pm',
    'lib/HTML/FormFu/Filter/LowerCase.pm',
    'lib/HTML/FormFu/Filter/NonNumeric.pm',
    'lib/HTML/FormFu/Filter/Regex.pm',
    'lib/HTML/FormFu/Filter/Split.pm',
    'lib/HTML/FormFu/Filter/TrimEdges.pm',
    'lib/HTML/FormFu/Filter/UpperCase.pm',
    'lib/HTML/FormFu/Filter/Whitespace.pm',
    'lib/HTML/FormFu/I18N.pm',
    'lib/HTML/FormFu/I18N/bg.pm',
    'lib/HTML/FormFu/I18N/cs.pm',
    'lib/HTML/FormFu/I18N/da.pm',
    'lib/HTML/FormFu/I18N/de.pm',
    'lib/HTML/FormFu/I18N/en.pm',
    'lib/HTML/FormFu/I18N/es.pm',
    'lib/HTML/FormFu/I18N/fr.pm',
    'lib/HTML/FormFu/I18N/hu.pm',
    'lib/HTML/FormFu/I18N/it.pm',
    'lib/HTML/FormFu/I18N/ja.pm',
    'lib/HTML/FormFu/I18N/no.pm',
    'lib/HTML/FormFu/I18N/pt_br.pm',
    'lib/HTML/FormFu/I18N/pt_pt.pm',
    'lib/HTML/FormFu/I18N/ro.pm',
    'lib/HTML/FormFu/I18N/ru.pm',
    'lib/HTML/FormFu/I18N/tr.pm',
    'lib/HTML/FormFu/I18N/ua.pm',
    'lib/HTML/FormFu/I18N/zh_cn.pm',
    'lib/HTML/FormFu/Inflator.pm',
    'lib/HTML/FormFu/Inflator/Callback.pm',
    'lib/HTML/FormFu/Inflator/CompoundDateTime.pm',
    'lib/HTML/FormFu/Inflator/DateTime.pm',
    'lib/HTML/FormFu/Literal.pm',
    'lib/HTML/FormFu/Localize.pm',
    'lib/HTML/FormFu/Manual/Cookbook.pod',
    'lib/HTML/FormFu/Manual/Unicode.pod',
    'lib/HTML/FormFu/Model.pm',
    'lib/HTML/FormFu/Model/HashRef.pm',
    'lib/HTML/FormFu/ObjectUtil.pm',
    'lib/HTML/FormFu/OutputProcessor.pm',
    'lib/HTML/FormFu/OutputProcessor/Indent.pm',
    'lib/HTML/FormFu/OutputProcessor/StripWhitespace.pm',
    'lib/HTML/FormFu/Plugin.pm',
    'lib/HTML/FormFu/Plugin/StashValid.pm',
    'lib/HTML/FormFu/Preload.pm',
    'lib/HTML/FormFu/Processor.pm',
    'lib/HTML/FormFu/QueryType/CGI.pm',
    'lib/HTML/FormFu/QueryType/CGI/Simple.pm',
    'lib/HTML/FormFu/QueryType/Catalyst.pm',
    'lib/HTML/FormFu/Role/Constraint/Others.pm',
    'lib/HTML/FormFu/Role/ContainsElements.pm',
    'lib/HTML/FormFu/Role/ContainsElementsSharedWithField.pm',
    'lib/HTML/FormFu/Role/CreateChildren.pm',
    'lib/HTML/FormFu/Role/CustomRoles.pm',
    'lib/HTML/FormFu/Role/Element/Coercible.pm',
    'lib/HTML/FormFu/Role/Element/Field.pm',
    'lib/HTML/FormFu/Role/Element/FieldMethods.pm',
    'lib/HTML/FormFu/Role/Element/Group.pm',
    'lib/HTML/FormFu/Role/Element/Input.pm',
    'lib/HTML/FormFu/Role/Element/Layout.pm',
    'lib/HTML/FormFu/Role/Element/MultiElement.pm',
    'lib/HTML/FormFu/Role/Element/NonBlock.pm',
    'lib/HTML/FormFu/Role/Element/ProcessOptionsFromModel.pm',
    'lib/HTML/FormFu/Role/Element/SingleValueField.pm',
    'lib/HTML/FormFu/Role/Filter/Compound.pm',
    'lib/HTML/FormFu/Role/FormAndBlockMethods.pm',
    'lib/HTML/FormFu/Role/FormAndElementMethods.pm',
    'lib/HTML/FormFu/Role/FormBlockAndFieldMethods.pm',
    'lib/HTML/FormFu/Role/GetProcessors.pm',
    'lib/HTML/FormFu/Role/HasParent.pm',
    'lib/HTML/FormFu/Role/NestedHashUtils.pm',
    'lib/HTML/FormFu/Role/Populate.pm',
    'lib/HTML/FormFu/Role/Render.pm',
    'lib/HTML/FormFu/Transformer.pm',
    'lib/HTML/FormFu/Transformer/Callback.pm',
    'lib/HTML/FormFu/Upload.pm',
    'lib/HTML/FormFu/UploadParam.pm',
    'lib/HTML/FormFu/Util.pm',
    'lib/HTML/FormFu/Validator.pm',
    'lib/HTML/FormFu/Validator/Callback.pm'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
