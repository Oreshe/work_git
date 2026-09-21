# Звіт з виконання TASK 03: CodeStyle Automation

## 1. Початковий стан та підготовка
- **Молодша версія (XX):** clang-format-17
- **Старша версія (YY):** clang-format-22
- **Початковий конфіг:** .clang-format з офіційного репозиторію Linux kernel

## 2. Результати перевірки чекером (check_format.sh)
```
CLANG-FORMAT 17 VERSION
./task03/dummy/include/kfd_ioctl.h:56:22: error: code should be clang-formatted [-Wclang-format-violations]
        __u32 major_version;    /* from KFD */
                            ^^^^
./task03/dummy/include/kfd_ioctl.h:57:22: error: code should be clang-formatted [-Wclang-format-violations]
        __u32 minor_version;    /* from KFD */
                            ^^^^
./task03/dummy/include/kfd_ioctl.h:61:35: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_IOC_QUEUE_TYPE_COMPUTE              0x0
                                  ^^^^^^
./task03/dummy/include/kfd_ioctl.h:62:32: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_IOC_QUEUE_TYPE_SDMA                 0x1
                               ^
./task03/dummy/include/kfd_ioctl.h:63:39: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_IOC_QUEUE_TYPE_COMPUTE_AQL          0x2
                                      ^^
./task03/dummy/include/kfd_ioctl.h:64:37: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_IOC_QUEUE_TYPE_SDMA_XGMI            0x3
                                    ^^^^
./task03/dummy/include/kfd_ioctl.h:65:42: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID       0x4
                                         ^^^^^^^
./task03/dummy/include/kfd_ioctl.h:67:33: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_MAX_QUEUE_PERCENTAGE        100
                                ^^^^^^^^
./task03/dummy/include/kfd_ioctl.h:68:31: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_MAX_QUEUE_PRIORITY          15
                              ^^
./task03/dummy/include/kfd_ioctl.h:70:32: error: code should be clang-formatted [-Wclang-format-violations]
#define KFD_MIN_QUEUE_RING_SIZE         1024
                               ^
./task03/dummy/include/kfd_ioctl.h:73:26: error: code should be clang-formatted [-Wclang-format-violations]
        __u64 ring_base_address;        /* to KFD */
                                ^^^^^^^^
./task03/dummy/include/kfd_ioctl.h:74:30: error: code should be clang-formatted [-Wclang-format-violations]
        __u64 write_pointer_address;    /* to KFD */
... [вивід дуже сильно скорочено]

```

## 3. Вплив автоформатування
### Статистика після clang-format-17:
```
 task03/Report.md                     |    4 +
 task03/dummy/include/ash.h           |   25 +-
 task03/dummy/include/assert.h        |  229 ++++---
 task03/dummy/include/bpf_elf.h       |   36 +-
 task03/dummy/include/capi.h          |   62 +-
 task03/dummy/include/cld.h           |   60 +-
 task03/dummy/include/debug.h         |   28 +-
 task03/dummy/include/ec.h            |   50 +-
 task03/dummy/include/err.h           |   46 +-
 task03/dummy/include/export.h        |   65 +-
 task03/dummy/include/fnmatch.h       |   34 +-
 task03/dummy/include/ftw.h           |  269 ++++-----
 task03/dummy/include/if_hippi.h      |  118 ++--
 task03/dummy/include/ip.h            |  151 +++--
 task03/dummy/include/kd.h            |  202 +++----
 task03/dummy/include/keyctl.h        |  163 ++---
 task03/dummy/include/kfd_ioctl.h     |  763 ++++++++++++------------
 task03/dummy/include/langinfo.h      | 1088 +++++++++++++++++-----------------
 task03/dummy/include/mcheck.h        |   28 +-
 task03/dummy/include/mqueue.h        |   93 ++-
 task03/dummy/include/netrom.h        |   91 ++-
 task03/dummy/include/sched.h         |  126 ++--
 task03/dummy/include/stats.h         |    2 +-
 task03/dummy/include/stdc-predef.h   |   30 +-
 task03/dummy/include/sudo_plugin.h   |  321 +++++-----
 task03/dummy/include/tcp_metrics.h   |   42 +-
 task03/dummy/include/trace_mmap.h    |   28 +-
 task03/dummy/include/ulimit.h        |   20 +-
 task03/dummy/include/v4l2-subdev.h   |   82 +--
 task03/dummy/src/conf.c              |  107 ++--
 task03/dummy/src/confdata.c          |   79 +--
 task03/dummy/src/expr.c              |  323 +++++-----
 task03/dummy/src/file2alias.c        |  403 ++++++-------
 task03/dummy/src/genksyms.c          |  114 ++--
 task03/dummy/src/keywords.c          |    2 +-
 task03/dummy/src/mdp.c               |   29 +-
 task03/dummy/src/mk_elfconfig.c      |    3 +-
 task03/dummy/src/modpost.c           |  399 ++++++-------
 task03/dummy/src/sign-file.c         |   96 +--
 task03/dummy/src/sorttable.c         |  168 +++---
 task03/dummy/src/sumversion.c        |   73 +--
 task03/dummy/src/symsearch.c         |   19 +-
 task03/dummy/src/tracepoint-update.c |   38 +-
 43 files changed, 3095 insertions(+), 3014 deletions(-)
```

### Статистика після clang-format-22 (поверх 17):
```
 task03/Report.md                 |  3 +++
 task03/dummy/include/bpf_elf.h   | 15 +++++++--------
 task03/dummy/include/kfd_ioctl.h |  2 +-
 task03/dummy/src/modpost.c       |  8 ++++----
 4 files changed, 15 insertions(+), 13 deletions(-)
```

## 4. Дослідження зміни версії форматування (Chromium)
```diff
--- task03/chromium-17.clang-format	2026-09-21 23:31:49.274803775 +0300
+++ task03/chromium-22.clang-format	2026-09-21 23:31:57.782949103 +0300
@@ -1,61 +1,102 @@
 ---
 Language:        Cpp
-# BasedOnStyle:  Chromium
+AlignAfterOpenBracket: true
 AccessModifierOffset: -1
-AlignAfterOpenBracket: Align
 AlignArrayOfStructures: None
 AlignConsecutiveAssignments:
   Enabled:         false
   AcrossEmptyLines: false
   AcrossComments:  false
   AlignCompound:   false
+  AlignFunctionDeclarations: false
+  AlignFunctionPointers: false
   PadOperators:    true
 AlignConsecutiveBitFields:
   Enabled:         false
   AcrossEmptyLines: false
   AcrossComments:  false
   AlignCompound:   false
+  AlignFunctionDeclarations: false
+  AlignFunctionPointers: false
   PadOperators:    false
 AlignConsecutiveDeclarations:
   Enabled:         false
   AcrossEmptyLines: false
   AcrossComments:  false
   AlignCompound:   false
+  AlignFunctionDeclarations: true
+  AlignFunctionPointers: false
   PadOperators:    false
 AlignConsecutiveMacros:
   Enabled:         false
   AcrossEmptyLines: false
   AcrossComments:  false
   AlignCompound:   false
+  AlignFunctionDeclarations: false
+  AlignFunctionPointers: false
   PadOperators:    false
 AlignConsecutiveShortCaseStatements:
   Enabled:         false
   AcrossEmptyLines: false
   AcrossComments:  false
+  AlignCaseArrows: false
   AlignCaseColons: false
+AlignConsecutiveTableGenBreakingDAGArgColons:
+  Enabled:         false
+  AcrossEmptyLines: false
+  AcrossComments:  false
+  AlignCompound:   false
+  AlignFunctionDeclarations: false
+  AlignFunctionPointers: false
+  PadOperators:    false
+AlignConsecutiveTableGenCondOperatorColons:
+  Enabled:         false
+  AcrossEmptyLines: false
+  AcrossComments:  false
+  AlignCompound:   false
+  AlignFunctionDeclarations: false
+  AlignFunctionPointers: false
+  PadOperators:    false
+AlignConsecutiveTableGenDefinitionColons:
+  Enabled:         false
+  AcrossEmptyLines: false
+  AcrossComments:  false
+  AlignCompound:   false
+  AlignFunctionDeclarations: false
+  AlignFunctionPointers: false
+  PadOperators:    false
 AlignEscapedNewlines: Left
 AlignOperands:   Align
 AlignTrailingComments:
+  AlignPPAndNotPP: true
   Kind:            Always
   OverEmptyLines:  0
 AllowAllArgumentsOnNextLine: true
 AllowAllParametersOfDeclarationOnNextLine: false
+AllowBreakBeforeNoexceptSpecifier: Never
+AllowBreakBeforeQtProperty: false
 AllowShortBlocksOnASingleLine: Never
+AllowShortCaseExpressionOnASingleLine: true
 AllowShortCaseLabelsOnASingleLine: false
+AllowShortCompoundRequirementOnASingleLine: true
 AllowShortEnumsOnASingleLine: true
 AllowShortFunctionsOnASingleLine: Inline
 AllowShortIfStatementsOnASingleLine: Never
 AllowShortLambdasOnASingleLine: All
 AllowShortLoopsOnASingleLine: false
+AllowShortNamespacesOnASingleLine: false
 AlwaysBreakAfterDefinitionReturnType: None
-AlwaysBreakAfterReturnType: None
 AlwaysBreakBeforeMultilineStrings: true
-AlwaysBreakTemplateDeclarations: Yes
 AttributeMacros:
   - __capability
+  - absl_nonnull
+  - absl_nullable
+  - absl_nullability_unknown
 BinPackArguments: true
-BinPackParameters: false
+BinPackLongBracedList: true
+BinPackParameters: OnePerLine
 BitFieldColonSpacing: Both
+BracedInitializerIndentWidth: -1
 BraceWrapping:
   AfterCaseLabel:  false
   AfterClass:      false
@@ -75,27 +116,44 @@
   SplitEmptyFunction: true
   SplitEmptyRecord: true
   SplitEmptyNamespace: true
-BreakAfterAttributes: Never
+BreakAdjacentStringLiterals: true
+BreakAfterAttributes: Leave
 BreakAfterJavaFieldAnnotations: false
+BreakAfterOpenBracketBracedList: false
+BreakAfterOpenBracketFunction: false
+BreakAfterOpenBracketIf: false
+BreakAfterOpenBracketLoop: false
+BreakAfterOpenBracketSwitch: false
+BreakAfterReturnType: None
 BreakArrays:     true
 BreakBeforeBinaryOperators: None
+BreakBeforeCloseBracketBracedList: false
+BreakBeforeCloseBracketFunction: false
+BreakBeforeCloseBracketIf: false
+BreakBeforeCloseBracketLoop: false
+BreakBeforeCloseBracketSwitch: false
 BreakBeforeConceptDeclarations: Always
 BreakBeforeBraces: Attach
 BreakBeforeInlineASMColon: OnlyMultiline
+BreakBeforeTemplateCloser: false
 BreakBeforeTernaryOperators: true
+BreakBinaryOperations: Never
 BreakConstructorInitializers: BeforeColon
+BreakFunctionDefinitionParameters: false
 BreakInheritanceList: BeforeColon
 BreakStringLiterals: true
+BreakTemplateDeclarations: Yes
 ColumnLimit:     80
 CommentPragmas:  '^ IWYU pragma:'
 CompactNamespaces: false
 ConstructorInitializerIndentWidth: 4
 ContinuationIndentWidth: 4
-Cpp11BracedListStyle: true
+Cpp11BracedListStyle: AlignFirstComment
 DerivePointerAlignment: false
 DisableFormat:   false
 EmptyLineAfterAccessModifier: Never
 EmptyLineBeforeAccessModifier: LogicalBlock
+EnumTrailingComma: Leave
 ExperimentalAutoDetectBinPacking: false
 FixNamespaceComments: true
 ForEachMacros:
@@ -127,6 +185,7 @@
 IndentAccessModifiers: false
 IndentCaseBlocks: false
 IndentCaseLabels: true
+IndentExportBlock: true
 IndentExternBlock: AfterExternBlock
 IndentGotoLabels: true
 IndentPPDirectives: None
@@ -138,32 +197,50 @@
 InsertTrailingCommas: None
 IntegerLiteralSeparator:
   Binary:          0
-  BinaryMinDigits: 0
+  BinaryMinDigitsInsert: 0
+  BinaryMaxDigitsRemove: 0
   Decimal:         0
-  DecimalMinDigits: 0
+  DecimalMinDigitsInsert: 0
+  DecimalMaxDigitsRemove: 0
   Hex:             0
+  HexMinDigitsInsert: 0
+  HexMaxDigitsRemove: 0
+  BinaryMinDigits: 0
+  DecimalMinDigits: 0
   HexMinDigits:    0
 JavaScriptQuotes: Leave
 JavaScriptWrapImports: true
-KeepEmptyLinesAtTheStartOfBlocks: false
-KeepEmptyLinesAtEOF: false
+KeepEmptyLines:
+  AtEndOfFile:     false
+  AtStartOfBlock:  false
+  AtStartOfFile:   true
+KeepFormFeed:    false
 LambdaBodyIndentation: Signature
 LineEnding:      DeriveLF
 MacroBlockBegin: ''
 MacroBlockEnd:   ''
+MainIncludeChar: Quote
 MaxEmptyLinesToKeep: 1
 NamespaceIndentation: None
+NumericLiteralCase:
+  ExponentLetter:  Leave
+  HexDigit:        Leave
+  Prefix:          Leave
+  Suffix:          Leave
 ObjCBinPackProtocolList: Never
 ObjCBlockIndentWidth: 2
 ObjCBreakBeforeNestedBlockParam: true
 ObjCSpaceAfterProperty: false
 ObjCSpaceBeforeProtocolList: true
+OneLineFormatOffRegex: ''
 PackConstructorInitializers: NextLine
 PenaltyBreakAssignment: 2
 PenaltyBreakBeforeFirstCallParameter: 1
+PenaltyBreakBeforeMemberAccess: 150
 PenaltyBreakComment: 300
 PenaltyBreakFirstLessLess: 120
 PenaltyBreakOpenParenthesis: 0
+PenaltyBreakScopeResolution: 500
 PenaltyBreakString: 1000
 PenaltyBreakTemplateDeclaration: 10
 PenaltyExcessCharacter: 1000000
@@ -203,19 +280,25 @@
     CanonicalDelimiter: pb
     BasedOnStyle:    google
 ReferenceAlignment: Pointer
-ReflowComments:  true
+ReflowComments:  Always
 RemoveBracesLLVM: false
+RemoveEmptyLinesInUnwrappedLines: false
 RemoveParentheses: Leave
 RemoveSemicolon: false
 RequiresClausePosition: OwnLine
 RequiresExpressionIndentation: OuterScope
 SeparateDefinitionBlocks: Leave
 ShortNamespaceLines: 1
-SortIncludes:    CaseSensitive
+SkipMacroDefinitionBody: false
+SortIncludes:
+  Enabled:         true
+  IgnoreCase:      false
+  IgnoreExtension: false
 SortJavaStaticImport: Before
 SortUsingDeclarations: LexicographicNumeric
 SpaceAfterCStyleCast: false
 SpaceAfterLogicalNot: false
+SpaceAfterOperatorKeyword: false
 SpaceAfterTemplateKeyword: true
 SpaceAroundPointerQualifiers: Default
 SpaceBeforeAssignmentOperators: true
@@ -231,13 +314,15 @@
   AfterFunctionDefinitionName: false
   AfterFunctionDeclarationName: false
   AfterIfMacros:   true
+  AfterNot:        false
   AfterOverloadedOperator: false
+  AfterPlacementOperator: true
   AfterRequiresInClause: false
   AfterRequiresInExpression: false
   BeforeNonEmptyParentheses: false
 SpaceBeforeRangeBasedForLoopColon: true
 SpaceBeforeSquareBrackets: false
-SpaceInEmptyBlock: false
+SpaceInEmptyBraces: Never
 SpacesBeforeTrailingComments: 2
 SpacesInAngles:  Never
 SpacesInContainerLiterals: true
@@ -246,6 +331,7 @@
   Maximum:         -1
 SpacesInParens:  Never
 SpacesInParensOptions:
+  ExceptDoubleParentheses: false
   InCStyleCasts:   false
   InConditionalStatements: false
   InEmptyParentheses: false
@@ -257,6 +343,7 @@
 StatementMacros:
   - Q_UNUSED
   - QT_REQUIRE_VERSION
+TableGenBreakInsideDAGArg: DontBreak
 TabWidth:        8
 UseTab:          Never
 VerilogBreakBetweenInstancePorts: true
@@ -266,5 +353,6 @@
   - NS_SWIFT_NAME
   - PP_STRINGIZE
   - STRINGIZE
+WrapNamespaceBodyWithEmptyLines: Leave
 ...
 
```

### Результат переходу на Chromium-17:
```
 task03/Report.md                           |    3 +
 task03/dummy/.clang-format                 | 1004 ++------
 task03/dummy/include/ash.h                 |   12 +-
 task03/dummy/include/assert.h              |   94 +-
 task03/dummy/include/bpf_elf.h             |   32 +-
 task03/dummy/include/capi.h                |   63 +-
 task03/dummy/include/cld.h                 |   68 +-
 task03/dummy/include/ec.h                  |   20 +-
 task03/dummy/include/err.h                 |   34 +-
 task03/dummy/include/export.h              |   14 +-
 task03/dummy/include/fnmatch.h             |   10 +-
 task03/dummy/include/ftw.h                 |  148 +-
 task03/dummy/include/if_hippi.h            |   92 +-
 task03/dummy/include/ip.h                  |  152 +-
 task03/dummy/include/kd.h                  |  110 +-
 task03/dummy/include/keyctl.h              |  144 +-
 task03/dummy/include/kfd_ioctl.h           | 1306 +++++-----
 task03/dummy/include/langinfo.h            |  885 ++++---
 task03/dummy/include/mcheck.h              |   12 +-
 task03/dummy/include/mqueue.h              |   76 +-
 task03/dummy/include/netrom.h              |   44 +-
 task03/dummy/include/rpl_iptunnel.h        |    6 +-
 task03/dummy/include/sched.h               |   45 +-
 task03/dummy/include/sudo_plugin.h         |  341 +--
 task03/dummy/include/tcp_metrics.h         |   76 +-
 task03/dummy/include/trace_mmap.h          |   36 +-
 task03/dummy/include/ulimit.h              |   16 +-
 task03/dummy/include/v4l2-subdev.h         |  146 +-
 task03/dummy/src/conf.c                    | 1611 ++++++------
 task03/dummy/src/confdata.c                | 1856 +++++++-------
 task03/dummy/src/devicetable-offsets.c     |  559 ++--
 task03/dummy/src/expr.c                    | 1908 +++++++-------
 task03/dummy/src/file2alias.c              | 2250 ++++++++--------
 task03/dummy/src/gen_packed_field_checks.c |   61 +-
 task03/dummy/src/genksyms.c                | 1410 +++++-----
 task03/dummy/src/keywords.c                |  142 +-
 task03/dummy/src/mdp.c                     |  324 ++-
 task03/dummy/src/mk_elfconfig.c            |   45 +-
 task03/dummy/src/mnconf-common.c           |   61 +-
 task03/dummy/src/modpost.c                 | 3812 ++++++++++++++--------------
 task03/dummy/src/polgen.c                  |  224 +-
 task03/dummy/src/sign-file.c               |  606 +++--
 task03/dummy/src/sorttable.c               | 1534 ++++++-----
 task03/dummy/src/sumversion.c              |  612 +++--
 task03/dummy/src/symsearch.c               |  246 +-
 task03/dummy/src/tracepoint-update.c       |  436 ++--
 46 files changed, 10898 insertions(+), 11788 deletions(-)
```

### Результат переходу на Chromium-22:
```
 task03/Report.md                 |   3 +
 task03/dummy/.clang-format       | 116 ++++++++++++++++++++++++++++++++++-----
 task03/dummy/include/bpf_elf.h   |  14 ++---
 task03/dummy/include/keyctl.h    |  78 ++++++++++++++------------
 task03/dummy/include/kfd_ioctl.h |   2 +-
 task03/dummy/src/file2alias.c    |  10 ++--
 task03/dummy/src/modpost.c       |   9 +--
 task03/make_format_17.sh         |  11 +++-
 task03/make_format_22.sh         |  11 +++-
 9 files changed, 181 insertions(+), 73 deletions(-)
```
## Підсумкові висновки
1. Різні версії clang-format (17 та 22) з однаковим файлом конфігурації можуть викликати незначні зміни у форматуванні коду через появу нових опцій та зміну поведінки за замовчуванням.
2. Автоматичне форматування коду за допомогою утиліти clang-format дозволяє підтримувати єдиний CodeStyle у проекті, проте перехід між мажорними версіями інструменту або зміна стилю генерує значний diff у репозиторії.
3. Для аналізу масштабних змін форматування в Git найкраще використовувати `git diff --stat` та `git diff --shortstat`, щоб не перевантажувати логи великим обсягом текстових дифів.
