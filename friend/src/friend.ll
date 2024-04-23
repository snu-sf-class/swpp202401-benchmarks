; ModuleID = '.tmp/a.ll'
source_filename = "friend/src/friend.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local ptr @malloc_upto_8(i64 noundef %x) #0 {
entry:
  %add = add i64 %x, 7
  %div = udiv i64 %add, 8
  %mul = mul i64 %div, 8
  %call = call noalias ptr @malloc(i64 noundef %mul) #4
  ret ptr %call
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @findSample(i32 noundef %n, ptr noundef %confidence, ptr noundef %host, ptr noundef %protocol) #0 {
entry:
  %conv = sext i32 %n to i64
  %mul = mul i64 8, %conv
  %call = call ptr @malloc_upto_8(i64 noundef %mul)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %confidence, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %mul2 = mul nsw i32 2, %i.0
  %idxprom3 = sext i32 %mul2 to i64
  %arrayidx4 = getelementptr inbounds i32, ptr %call, i64 %idxprom3
  store i32 %0, ptr %arrayidx4, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %sub = sub nsw i32 %n, 1
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc200, %for.end
  %i.1 = phi i32 [ %sub, %for.end ], [ %dec, %for.inc200 ]
  %cmp6 = icmp sge i32 %i.1, 1
  br i1 %cmp6, label %for.body8, label %for.end201

for.body8:                                        ; preds = %for.cond5
  %idxprom9 = sext i32 %i.1 to i64
  %arrayidx10 = getelementptr inbounds i32, ptr %protocol, i64 %idxprom9
  %1 = load i32, ptr %arrayidx10, align 4
  switch i32 %1, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb43
  ]

sw.bb:                                            ; preds = %for.body8
  %mul11 = mul nsw i32 2, %i.1
  %add = add nsw i32 %mul11, 1
  %idxprom12 = sext i32 %add to i64
  %arrayidx13 = getelementptr inbounds i32, ptr %call, i64 %idxprom12
  %2 = load i32, ptr %arrayidx13, align 4
  %idxprom14 = sext i32 %i.1 to i64
  %arrayidx15 = getelementptr inbounds i32, ptr %host, i64 %idxprom14
  %3 = load i32, ptr %arrayidx15, align 4
  %mul16 = mul nsw i32 2, %3
  %idxprom17 = sext i32 %mul16 to i64
  %arrayidx18 = getelementptr inbounds i32, ptr %call, i64 %idxprom17
  %4 = load i32, ptr %arrayidx18, align 4
  %add19 = add nsw i32 %4, %2
  store i32 %add19, ptr %arrayidx18, align 4
  %mul20 = mul nsw i32 2, %i.1
  %idxprom21 = sext i32 %mul20 to i64
  %arrayidx22 = getelementptr inbounds i32, ptr %call, i64 %idxprom21
  %5 = load i32, ptr %arrayidx22, align 4
  %mul23 = mul nsw i32 2, %i.1
  %add24 = add nsw i32 %mul23, 1
  %idxprom25 = sext i32 %add24 to i64
  %arrayidx26 = getelementptr inbounds i32, ptr %call, i64 %idxprom25
  %6 = load i32, ptr %arrayidx26, align 4
  %cmp27 = icmp sgt i32 %5, %6
  br i1 %cmp27, label %cond.true, label %cond.false

cond.true:                                        ; preds = %sw.bb
  %mul29 = mul nsw i32 2, %i.1
  %idxprom30 = sext i32 %mul29 to i64
  %arrayidx31 = getelementptr inbounds i32, ptr %call, i64 %idxprom30
  %7 = load i32, ptr %arrayidx31, align 4
  br label %cond.end

cond.false:                                       ; preds = %sw.bb
  %mul32 = mul nsw i32 2, %i.1
  %add33 = add nsw i32 %mul32, 1
  %idxprom34 = sext i32 %add33 to i64
  %arrayidx35 = getelementptr inbounds i32, ptr %call, i64 %idxprom34
  %8 = load i32, ptr %arrayidx35, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %7, %cond.true ], [ %8, %cond.false ]
  %idxprom36 = sext i32 %i.1 to i64
  %arrayidx37 = getelementptr inbounds i32, ptr %host, i64 %idxprom36
  %9 = load i32, ptr %arrayidx37, align 4
  %mul38 = mul nsw i32 2, %9
  %add39 = add nsw i32 %mul38, 1
  %idxprom40 = sext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds i32, ptr %call, i64 %idxprom40
  %10 = load i32, ptr %arrayidx41, align 4
  %add42 = add nsw i32 %10, %cond
  store i32 %add42, ptr %arrayidx41, align 4
  br label %sw.epilog

sw.bb43:                                          ; preds = %for.body8
  %idxprom44 = sext i32 %i.1 to i64
  %arrayidx45 = getelementptr inbounds i32, ptr %host, i64 %idxprom44
  %11 = load i32, ptr %arrayidx45, align 4
  %mul46 = mul nsw i32 2, %11
  %idxprom47 = sext i32 %mul46 to i64
  %arrayidx48 = getelementptr inbounds i32, ptr %call, i64 %idxprom47
  %12 = load i32, ptr %arrayidx48, align 4
  %mul49 = mul nsw i32 2, %i.1
  %idxprom50 = sext i32 %mul49 to i64
  %arrayidx51 = getelementptr inbounds i32, ptr %call, i64 %idxprom50
  %13 = load i32, ptr %arrayidx51, align 4
  %mul52 = mul nsw i32 2, %i.1
  %add53 = add nsw i32 %mul52, 1
  %idxprom54 = sext i32 %add53 to i64
  %arrayidx55 = getelementptr inbounds i32, ptr %call, i64 %idxprom54
  %14 = load i32, ptr %arrayidx55, align 4
  %cmp56 = icmp sgt i32 %13, %14
  br i1 %cmp56, label %cond.true58, label %cond.false62

cond.true58:                                      ; preds = %sw.bb43
  %mul59 = mul nsw i32 2, %i.1
  %idxprom60 = sext i32 %mul59 to i64
  %arrayidx61 = getelementptr inbounds i32, ptr %call, i64 %idxprom60
  %15 = load i32, ptr %arrayidx61, align 4
  br label %cond.end67

cond.false62:                                     ; preds = %sw.bb43
  %mul63 = mul nsw i32 2, %i.1
  %add64 = add nsw i32 %mul63, 1
  %idxprom65 = sext i32 %add64 to i64
  %arrayidx66 = getelementptr inbounds i32, ptr %call, i64 %idxprom65
  %16 = load i32, ptr %arrayidx66, align 4
  br label %cond.end67

cond.end67:                                       ; preds = %cond.false62, %cond.true58
  %cond68 = phi i32 [ %15, %cond.true58 ], [ %16, %cond.false62 ]
  %add69 = add nsw i32 %12, %cond68
  %idxprom70 = sext i32 %i.1 to i64
  %arrayidx71 = getelementptr inbounds i32, ptr %host, i64 %idxprom70
  %17 = load i32, ptr %arrayidx71, align 4
  %mul72 = mul nsw i32 2, %17
  %add73 = add nsw i32 %mul72, 1
  %idxprom74 = sext i32 %add73 to i64
  %arrayidx75 = getelementptr inbounds i32, ptr %call, i64 %idxprom74
  %18 = load i32, ptr %arrayidx75, align 4
  %mul76 = mul nsw i32 2, %i.1
  %idxprom77 = sext i32 %mul76 to i64
  %arrayidx78 = getelementptr inbounds i32, ptr %call, i64 %idxprom77
  %19 = load i32, ptr %arrayidx78, align 4
  %add79 = add nsw i32 %18, %19
  %cmp80 = icmp sgt i32 %add69, %add79
  br i1 %cmp80, label %cond.true82, label %cond.false109

cond.true82:                                      ; preds = %cond.end67
  %idxprom83 = sext i32 %i.1 to i64
  %arrayidx84 = getelementptr inbounds i32, ptr %host, i64 %idxprom83
  %20 = load i32, ptr %arrayidx84, align 4
  %mul85 = mul nsw i32 2, %20
  %idxprom86 = sext i32 %mul85 to i64
  %arrayidx87 = getelementptr inbounds i32, ptr %call, i64 %idxprom86
  %21 = load i32, ptr %arrayidx87, align 4
  %mul88 = mul nsw i32 2, %i.1
  %idxprom89 = sext i32 %mul88 to i64
  %arrayidx90 = getelementptr inbounds i32, ptr %call, i64 %idxprom89
  %22 = load i32, ptr %arrayidx90, align 4
  %mul91 = mul nsw i32 2, %i.1
  %add92 = add nsw i32 %mul91, 1
  %idxprom93 = sext i32 %add92 to i64
  %arrayidx94 = getelementptr inbounds i32, ptr %call, i64 %idxprom93
  %23 = load i32, ptr %arrayidx94, align 4
  %cmp95 = icmp sgt i32 %22, %23
  br i1 %cmp95, label %cond.true97, label %cond.false101

cond.true97:                                      ; preds = %cond.true82
  %mul98 = mul nsw i32 2, %i.1
  %idxprom99 = sext i32 %mul98 to i64
  %arrayidx100 = getelementptr inbounds i32, ptr %call, i64 %idxprom99
  %24 = load i32, ptr %arrayidx100, align 4
  br label %cond.end106

cond.false101:                                    ; preds = %cond.true82
  %mul102 = mul nsw i32 2, %i.1
  %add103 = add nsw i32 %mul102, 1
  %idxprom104 = sext i32 %add103 to i64
  %arrayidx105 = getelementptr inbounds i32, ptr %call, i64 %idxprom104
  %25 = load i32, ptr %arrayidx105, align 4
  br label %cond.end106

cond.end106:                                      ; preds = %cond.false101, %cond.true97
  %cond107 = phi i32 [ %24, %cond.true97 ], [ %25, %cond.false101 ]
  %add108 = add nsw i32 %21, %cond107
  br label %cond.end120

cond.false109:                                    ; preds = %cond.end67
  %idxprom110 = sext i32 %i.1 to i64
  %arrayidx111 = getelementptr inbounds i32, ptr %host, i64 %idxprom110
  %26 = load i32, ptr %arrayidx111, align 4
  %mul112 = mul nsw i32 2, %26
  %add113 = add nsw i32 %mul112, 1
  %idxprom114 = sext i32 %add113 to i64
  %arrayidx115 = getelementptr inbounds i32, ptr %call, i64 %idxprom114
  %27 = load i32, ptr %arrayidx115, align 4
  %mul116 = mul nsw i32 2, %i.1
  %idxprom117 = sext i32 %mul116 to i64
  %arrayidx118 = getelementptr inbounds i32, ptr %call, i64 %idxprom117
  %28 = load i32, ptr %arrayidx118, align 4
  %add119 = add nsw i32 %27, %28
  br label %cond.end120

cond.end120:                                      ; preds = %cond.false109, %cond.end106
  %cond121 = phi i32 [ %add108, %cond.end106 ], [ %add119, %cond.false109 ]
  %idxprom122 = sext i32 %i.1 to i64
  %arrayidx123 = getelementptr inbounds i32, ptr %host, i64 %idxprom122
  %29 = load i32, ptr %arrayidx123, align 4
  %mul124 = mul nsw i32 2, %29
  %idxprom125 = sext i32 %mul124 to i64
  %arrayidx126 = getelementptr inbounds i32, ptr %call, i64 %idxprom125
  store i32 %cond121, ptr %arrayidx126, align 4
  %mul127 = mul nsw i32 2, %i.1
  %add128 = add nsw i32 %mul127, 1
  %idxprom129 = sext i32 %add128 to i64
  %arrayidx130 = getelementptr inbounds i32, ptr %call, i64 %idxprom129
  %30 = load i32, ptr %arrayidx130, align 4
  %idxprom131 = sext i32 %i.1 to i64
  %arrayidx132 = getelementptr inbounds i32, ptr %host, i64 %idxprom131
  %31 = load i32, ptr %arrayidx132, align 4
  %mul133 = mul nsw i32 2, %31
  %add134 = add nsw i32 %mul133, 1
  %idxprom135 = sext i32 %add134 to i64
  %arrayidx136 = getelementptr inbounds i32, ptr %call, i64 %idxprom135
  %32 = load i32, ptr %arrayidx136, align 4
  %add137 = add nsw i32 %32, %30
  store i32 %add137, ptr %arrayidx136, align 4
  br label %sw.epilog

sw.default:                                       ; preds = %for.body8
  %idxprom138 = sext i32 %i.1 to i64
  %arrayidx139 = getelementptr inbounds i32, ptr %host, i64 %idxprom138
  %33 = load i32, ptr %arrayidx139, align 4
  %mul140 = mul nsw i32 2, %33
  %idxprom141 = sext i32 %mul140 to i64
  %arrayidx142 = getelementptr inbounds i32, ptr %call, i64 %idxprom141
  %34 = load i32, ptr %arrayidx142, align 4
  %mul143 = mul nsw i32 2, %i.1
  %add144 = add nsw i32 %mul143, 1
  %idxprom145 = sext i32 %add144 to i64
  %arrayidx146 = getelementptr inbounds i32, ptr %call, i64 %idxprom145
  %35 = load i32, ptr %arrayidx146, align 4
  %add147 = add nsw i32 %34, %35
  %idxprom148 = sext i32 %i.1 to i64
  %arrayidx149 = getelementptr inbounds i32, ptr %host, i64 %idxprom148
  %36 = load i32, ptr %arrayidx149, align 4
  %mul150 = mul nsw i32 2, %36
  %add151 = add nsw i32 %mul150, 1
  %idxprom152 = sext i32 %add151 to i64
  %arrayidx153 = getelementptr inbounds i32, ptr %call, i64 %idxprom152
  %37 = load i32, ptr %arrayidx153, align 4
  %mul154 = mul nsw i32 2, %i.1
  %idxprom155 = sext i32 %mul154 to i64
  %arrayidx156 = getelementptr inbounds i32, ptr %call, i64 %idxprom155
  %38 = load i32, ptr %arrayidx156, align 4
  %add157 = add nsw i32 %37, %38
  %cmp158 = icmp sgt i32 %add147, %add157
  br i1 %cmp158, label %cond.true160, label %cond.false171

cond.true160:                                     ; preds = %sw.default
  %idxprom161 = sext i32 %i.1 to i64
  %arrayidx162 = getelementptr inbounds i32, ptr %host, i64 %idxprom161
  %39 = load i32, ptr %arrayidx162, align 4
  %mul163 = mul nsw i32 2, %39
  %idxprom164 = sext i32 %mul163 to i64
  %arrayidx165 = getelementptr inbounds i32, ptr %call, i64 %idxprom164
  %40 = load i32, ptr %arrayidx165, align 4
  %mul166 = mul nsw i32 2, %i.1
  %add167 = add nsw i32 %mul166, 1
  %idxprom168 = sext i32 %add167 to i64
  %arrayidx169 = getelementptr inbounds i32, ptr %call, i64 %idxprom168
  %41 = load i32, ptr %arrayidx169, align 4
  %add170 = add nsw i32 %40, %41
  br label %cond.end182

cond.false171:                                    ; preds = %sw.default
  %idxprom172 = sext i32 %i.1 to i64
  %arrayidx173 = getelementptr inbounds i32, ptr %host, i64 %idxprom172
  %42 = load i32, ptr %arrayidx173, align 4
  %mul174 = mul nsw i32 2, %42
  %add175 = add nsw i32 %mul174, 1
  %idxprom176 = sext i32 %add175 to i64
  %arrayidx177 = getelementptr inbounds i32, ptr %call, i64 %idxprom176
  %43 = load i32, ptr %arrayidx177, align 4
  %mul178 = mul nsw i32 2, %i.1
  %idxprom179 = sext i32 %mul178 to i64
  %arrayidx180 = getelementptr inbounds i32, ptr %call, i64 %idxprom179
  %44 = load i32, ptr %arrayidx180, align 4
  %add181 = add nsw i32 %43, %44
  br label %cond.end182

cond.end182:                                      ; preds = %cond.false171, %cond.true160
  %cond183 = phi i32 [ %add170, %cond.true160 ], [ %add181, %cond.false171 ]
  %idxprom184 = sext i32 %i.1 to i64
  %arrayidx185 = getelementptr inbounds i32, ptr %host, i64 %idxprom184
  %45 = load i32, ptr %arrayidx185, align 4
  %mul186 = mul nsw i32 2, %45
  %idxprom187 = sext i32 %mul186 to i64
  %arrayidx188 = getelementptr inbounds i32, ptr %call, i64 %idxprom187
  store i32 %cond183, ptr %arrayidx188, align 4
  %mul189 = mul nsw i32 2, %i.1
  %add190 = add nsw i32 %mul189, 1
  %idxprom191 = sext i32 %add190 to i64
  %arrayidx192 = getelementptr inbounds i32, ptr %call, i64 %idxprom191
  %46 = load i32, ptr %arrayidx192, align 4
  %idxprom193 = sext i32 %i.1 to i64
  %arrayidx194 = getelementptr inbounds i32, ptr %host, i64 %idxprom193
  %47 = load i32, ptr %arrayidx194, align 4
  %mul195 = mul nsw i32 2, %47
  %add196 = add nsw i32 %mul195, 1
  %idxprom197 = sext i32 %add196 to i64
  %arrayidx198 = getelementptr inbounds i32, ptr %call, i64 %idxprom197
  %48 = load i32, ptr %arrayidx198, align 4
  %add199 = add nsw i32 %48, %46
  store i32 %add199, ptr %arrayidx198, align 4
  br label %sw.epilog

sw.epilog:                                        ; preds = %cond.end182, %cond.end120, %cond.end
  br label %for.inc200

for.inc200:                                       ; preds = %sw.epilog
  %dec = add nsw i32 %i.1, -1
  br label %for.cond5, !llvm.loop !8

for.end201:                                       ; preds = %for.cond5
  %arrayidx202 = getelementptr inbounds i32, ptr %call, i64 0
  %49 = load i32, ptr %arrayidx202, align 4
  %arrayidx203 = getelementptr inbounds i32, ptr %call, i64 1
  %50 = load i32, ptr %arrayidx203, align 4
  %cmp204 = icmp sgt i32 %49, %50
  br i1 %cmp204, label %cond.true206, label %cond.false208

cond.true206:                                     ; preds = %for.end201
  %arrayidx207 = getelementptr inbounds i32, ptr %call, i64 0
  %51 = load i32, ptr %arrayidx207, align 4
  br label %cond.end210

cond.false208:                                    ; preds = %for.end201
  %arrayidx209 = getelementptr inbounds i32, ptr %call, i64 1
  %52 = load i32, ptr %arrayidx209, align 4
  br label %cond.end210

cond.end210:                                      ; preds = %cond.false208, %cond.true206
  %cond211 = phi i32 [ %51, %cond.true206 ], [ %52, %cond.false208 ]
  ret i32 %cond211
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  %conv1 = sext i32 %conv to i64
  %mul = mul i64 4, %conv1
  %call2 = call ptr @malloc_upto_8(i64 noundef %mul)
  %conv3 = sext i32 %conv to i64
  %mul4 = mul i64 4, %conv3
  %call5 = call ptr @malloc_upto_8(i64 noundef %mul4)
  %conv6 = sext i32 %conv to i64
  %mul7 = mul i64 4, %conv6
  %call8 = call ptr @malloc_upto_8(i64 noundef %mul7)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %conv
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call10 = call i64 (...) @read()
  %conv11 = trunc i64 %call10 to i32
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %call2, i64 %idxprom
  store i32 %conv11, ptr %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !9

for.end:                                          ; preds = %for.cond
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc24, %for.end
  %i.1 = phi i32 [ 1, %for.end ], [ %inc25, %for.inc24 ]
  %cmp13 = icmp slt i32 %i.1, %conv
  br i1 %cmp13, label %for.body15, label %for.end26

for.body15:                                       ; preds = %for.cond12
  %call16 = call i64 (...) @read()
  %conv17 = trunc i64 %call16 to i32
  %idxprom18 = sext i32 %i.1 to i64
  %arrayidx19 = getelementptr inbounds i32, ptr %call5, i64 %idxprom18
  store i32 %conv17, ptr %arrayidx19, align 4
  %call20 = call i64 (...) @read()
  %conv21 = trunc i64 %call20 to i32
  %idxprom22 = sext i32 %i.1 to i64
  %arrayidx23 = getelementptr inbounds i32, ptr %call8, i64 %idxprom22
  store i32 %conv21, ptr %arrayidx23, align 4
  br label %for.inc24

for.inc24:                                        ; preds = %for.body15
  %inc25 = add nsw i32 %i.1, 1
  br label %for.cond12, !llvm.loop !10

for.end26:                                        ; preds = %for.cond12
  %call27 = call i32 @findSample(i32 noundef %conv, ptr noundef %call2, ptr noundef %call5, ptr noundef %call8)
  %conv28 = sext i32 %call27 to i64
  call void @write(i64 noundef %conv28)
  ret i32 0
}

declare i64 @read(...) #3

declare void @write(i64 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 18.1.0rc (https://github.com/llvm/llvm-project.git 461274b81d8641eab64d494accddc81d7db8a09e)"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.unroll.disable"}
!8 = distinct !{!8, !6, !7}
!9 = distinct !{!9, !6, !7}
!10 = distinct !{!10, !6, !7}
