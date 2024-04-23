; ModuleID = '.tmp/a.ll'
source_filename = "merge_sort/src/merge_sort.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local ptr @malloc_upto_8(i64 noundef %x) #0 {
entry:
  %add = add i64 %x, 7
  %div = udiv i64 %add, 8
  %mul = mul i64 %div, 8
  %call = call noalias ptr @malloc(i64 noundef %mul) #5
  ret ptr %call
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: nounwind uwtable
define dso_local void @merge(ptr noundef %arr, i32 noundef %l, i32 noundef %m, i32 noundef %r) #0 {
entry:
  %sub = sub nsw i32 %m, %l
  %add = add nsw i32 %sub, 1
  %sub1 = sub nsw i32 %r, %m
  %conv = sext i32 %add to i64
  %mul = mul i64 4, %conv
  %call = call ptr @malloc_upto_8(i64 noundef %mul)
  %conv2 = sext i32 %sub1 to i64
  %mul3 = mul i64 4, %conv2
  %call4 = call ptr @malloc_upto_8(i64 noundef %mul3)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %add
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %add6 = add nsw i32 %l, %i.0
  %idxprom = sext i32 %add6 to i64
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %idxprom7 = sext i32 %i.0 to i64
  %arrayidx8 = getelementptr inbounds i32, ptr %call, i64 %idxprom7
  store i32 %0, ptr %arrayidx8, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc19, %for.end
  %j.0 = phi i32 [ 0, %for.end ], [ %inc20, %for.inc19 ]
  %cmp10 = icmp slt i32 %j.0, %sub1
  br i1 %cmp10, label %for.body12, label %for.end21

for.body12:                                       ; preds = %for.cond9
  %add13 = add nsw i32 %m, 1
  %add14 = add nsw i32 %add13, %j.0
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds i32, ptr %arr, i64 %idxprom15
  %1 = load i32, ptr %arrayidx16, align 4
  %idxprom17 = sext i32 %j.0 to i64
  %arrayidx18 = getelementptr inbounds i32, ptr %call4, i64 %idxprom17
  store i32 %1, ptr %arrayidx18, align 4
  br label %for.inc19

for.inc19:                                        ; preds = %for.body12
  %inc20 = add nsw i32 %j.0, 1
  br label %for.cond9, !llvm.loop !8

for.end21:                                        ; preds = %for.cond9
  br label %while.cond

while.cond:                                       ; preds = %if.end, %for.end21
  %k.0 = phi i32 [ %l, %for.end21 ], [ %inc42, %if.end ]
  %j.1 = phi i32 [ 0, %for.end21 ], [ %j.2, %if.end ]
  %i.1 = phi i32 [ 0, %for.end21 ], [ %i.2, %if.end ]
  %cmp22 = icmp slt i32 %i.1, %add
  br i1 %cmp22, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %cmp24 = icmp slt i32 %j.1, %sub1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %2 = phi i1 [ false, %while.cond ], [ %cmp24, %land.rhs ]
  br i1 %2, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %idxprom26 = sext i32 %i.1 to i64
  %arrayidx27 = getelementptr inbounds i32, ptr %call, i64 %idxprom26
  %3 = load i32, ptr %arrayidx27, align 4
  %idxprom28 = sext i32 %j.1 to i64
  %arrayidx29 = getelementptr inbounds i32, ptr %call4, i64 %idxprom28
  %4 = load i32, ptr %arrayidx29, align 4
  %cmp30 = icmp sle i32 %3, %4
  br i1 %cmp30, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %idxprom32 = sext i32 %i.1 to i64
  %arrayidx33 = getelementptr inbounds i32, ptr %call, i64 %idxprom32
  %5 = load i32, ptr %arrayidx33, align 4
  %idxprom34 = sext i32 %k.0 to i64
  %arrayidx35 = getelementptr inbounds i32, ptr %arr, i64 %idxprom34
  store i32 %5, ptr %arrayidx35, align 4
  %inc36 = add nsw i32 %i.1, 1
  br label %if.end

if.else:                                          ; preds = %while.body
  %idxprom37 = sext i32 %j.1 to i64
  %arrayidx38 = getelementptr inbounds i32, ptr %call4, i64 %idxprom37
  %6 = load i32, ptr %arrayidx38, align 4
  %idxprom39 = sext i32 %k.0 to i64
  %arrayidx40 = getelementptr inbounds i32, ptr %arr, i64 %idxprom39
  store i32 %6, ptr %arrayidx40, align 4
  %inc41 = add nsw i32 %j.1, 1
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %j.2 = phi i32 [ %j.1, %if.then ], [ %inc41, %if.else ]
  %i.2 = phi i32 [ %inc36, %if.then ], [ %i.1, %if.else ]
  %inc42 = add nsw i32 %k.0, 1
  br label %while.cond, !llvm.loop !9

while.end:                                        ; preds = %land.end
  br label %while.cond43

while.cond43:                                     ; preds = %while.body46, %while.end
  %k.1 = phi i32 [ %k.0, %while.end ], [ %inc52, %while.body46 ]
  %i.3 = phi i32 [ %i.1, %while.end ], [ %inc51, %while.body46 ]
  %cmp44 = icmp slt i32 %i.3, %add
  br i1 %cmp44, label %while.body46, label %while.end53

while.body46:                                     ; preds = %while.cond43
  %idxprom47 = sext i32 %i.3 to i64
  %arrayidx48 = getelementptr inbounds i32, ptr %call, i64 %idxprom47
  %7 = load i32, ptr %arrayidx48, align 4
  %idxprom49 = sext i32 %k.1 to i64
  %arrayidx50 = getelementptr inbounds i32, ptr %arr, i64 %idxprom49
  store i32 %7, ptr %arrayidx50, align 4
  %inc51 = add nsw i32 %i.3, 1
  %inc52 = add nsw i32 %k.1, 1
  br label %while.cond43, !llvm.loop !10

while.end53:                                      ; preds = %while.cond43
  br label %while.cond54

while.cond54:                                     ; preds = %while.body57, %while.end53
  %k.2 = phi i32 [ %k.1, %while.end53 ], [ %inc63, %while.body57 ]
  %j.3 = phi i32 [ %j.1, %while.end53 ], [ %inc62, %while.body57 ]
  %cmp55 = icmp slt i32 %j.3, %sub1
  br i1 %cmp55, label %while.body57, label %while.end64

while.body57:                                     ; preds = %while.cond54
  %idxprom58 = sext i32 %j.3 to i64
  %arrayidx59 = getelementptr inbounds i32, ptr %call4, i64 %idxprom58
  %8 = load i32, ptr %arrayidx59, align 4
  %idxprom60 = sext i32 %k.2 to i64
  %arrayidx61 = getelementptr inbounds i32, ptr %arr, i64 %idxprom60
  store i32 %8, ptr %arrayidx61, align 4
  %inc62 = add nsw i32 %j.3, 1
  %inc63 = add nsw i32 %k.2, 1
  br label %while.cond54, !llvm.loop !11

while.end64:                                      ; preds = %while.cond54
  call void @free(ptr noundef %call) #6
  call void @free(ptr noundef %call4) #6
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local void @mergeSort(ptr noundef %arr, i32 noundef %l, i32 noundef %r) #0 {
entry:
  %cmp = icmp slt i32 %l, %r
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sub = sub nsw i32 %r, %l
  %div = sdiv i32 %sub, 2
  %add = add nsw i32 %l, %div
  call void @mergeSort(ptr noundef %arr, i32 noundef %l, i32 noundef %add)
  %add1 = add nsw i32 %add, 1
  call void @mergeSort(ptr noundef %arr, i32 noundef %add1, i32 noundef %r)
  call void @merge(ptr noundef %arr, i32 noundef %l, i32 noundef %add, i32 noundef %r)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %mul = mul i64 4, %call
  %call1 = call ptr @malloc_upto_8(i64 noundef %mul)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %conv = sext i32 %i.0 to i64
  %cmp = icmp ult i64 %conv, %call
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %call3 = call i64 (...) @read()
  %conv4 = trunc i64 %call3 to i32
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %call1, i64 %idxprom
  store i32 %conv4, ptr %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !12

for.end:                                          ; preds = %for.cond.cleanup
  %sub = sub i64 %call, 1
  %conv5 = trunc i64 %sub to i32
  call void @mergeSort(ptr noundef %call1, i32 noundef 0, i32 noundef %conv5)
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc16, %for.end
  %i6.0 = phi i32 [ 0, %for.end ], [ %inc17, %for.inc16 ]
  %conv8 = sext i32 %i6.0 to i64
  %cmp9 = icmp ult i64 %conv8, %call
  br i1 %cmp9, label %for.body12, label %for.cond.cleanup11

for.cond.cleanup11:                               ; preds = %for.cond7
  br label %for.end18

for.body12:                                       ; preds = %for.cond7
  %idxprom13 = sext i32 %i6.0 to i64
  %arrayidx14 = getelementptr inbounds i32, ptr %call1, i64 %idxprom13
  %0 = load i32, ptr %arrayidx14, align 4
  %conv15 = sext i32 %0 to i64
  call void @write(i64 noundef %conv15)
  br label %for.inc16

for.inc16:                                        ; preds = %for.body12
  %inc17 = add nsw i32 %i6.0, 1
  br label %for.cond7, !llvm.loop !13

for.end18:                                        ; preds = %for.cond.cleanup11
  call void @free(ptr noundef %call1) #6
  ret i32 0
}

declare i64 @read(...) #4

declare void @write(i64 noundef) #4

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind allocsize(0) }
attributes #6 = { nounwind }

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
!11 = distinct !{!11, !6, !7}
!12 = distinct !{!12, !6, !7}
!13 = distinct !{!13, !6, !7}
