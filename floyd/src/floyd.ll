; ModuleID = '.tmp/a.ll'
source_filename = "floyd/src/floyd.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@graph = external global ptr, align 8
@cycle_pos = external global i64, align 8
@cycle_len = external global i64, align 8

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
define dso_local ptr @advance(ptr noundef %node) #0 {
entry:
  %0 = load i16, ptr %node, align 2
  %conv = zext i16 %0 to i64
  %1 = load ptr, ptr @graph, align 8
  %arrayidx = getelementptr inbounds i16, ptr %1, i64 %conv
  ret ptr %arrayidx
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local void @floyd() #0 {
entry:
  %0 = load ptr, ptr @graph, align 8
  %call = call ptr @advance(ptr noundef %0)
  %1 = load ptr, ptr @graph, align 8
  %call1 = call ptr @advance(ptr noundef %1)
  %call2 = call ptr @advance(ptr noundef %call1)
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %tortoise.0 = phi ptr [ %call, %entry ], [ %call3, %while.body ]
  %hare.0 = phi ptr [ %call2, %entry ], [ %call5, %while.body ]
  %cmp = icmp ne ptr %tortoise.0, %hare.0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %call3 = call ptr @advance(ptr noundef %tortoise.0)
  %call4 = call ptr @advance(ptr noundef %hare.0)
  %call5 = call ptr @advance(ptr noundef %call4)
  br label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %while.cond
  store i64 0, ptr @cycle_pos, align 8
  %2 = load ptr, ptr @graph, align 8
  br label %while.cond6

while.cond6:                                      ; preds = %while.body8, %while.end
  %tortoise.1 = phi ptr [ %2, %while.end ], [ %call9, %while.body8 ]
  %hare.1 = phi ptr [ %hare.0, %while.end ], [ %call10, %while.body8 ]
  %cmp7 = icmp ne ptr %tortoise.1, %hare.1
  br i1 %cmp7, label %while.body8, label %while.end11

while.body8:                                      ; preds = %while.cond6
  %call9 = call ptr @advance(ptr noundef %tortoise.1)
  %call10 = call ptr @advance(ptr noundef %hare.1)
  %3 = load i64, ptr @cycle_pos, align 8
  %add = add i64 %3, 1
  store i64 %add, ptr @cycle_pos, align 8
  br label %while.cond6, !llvm.loop !8

while.end11:                                      ; preds = %while.cond6
  store i64 1, ptr @cycle_len, align 8
  %call12 = call ptr @advance(ptr noundef %tortoise.1)
  br label %while.cond13

while.cond13:                                     ; preds = %while.body15, %while.end11
  %hare.2 = phi ptr [ %call12, %while.end11 ], [ %call16, %while.body15 ]
  %cmp14 = icmp ne ptr %tortoise.1, %hare.2
  br i1 %cmp14, label %while.body15, label %while.end18

while.body15:                                     ; preds = %while.cond13
  %call16 = call ptr @advance(ptr noundef %hare.2)
  %4 = load i64, ptr @cycle_len, align 8
  %add17 = add i64 %4, 1
  store i64 %add17, ptr @cycle_len, align 8
  br label %while.cond13, !llvm.loop !9

while.end18:                                      ; preds = %while.cond13
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %mul = mul i64 %call, 2
  %call1 = call ptr @malloc_upto_8(i64 noundef %mul)
  store ptr %call1, ptr @graph, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i64 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i64 %i.0, %call
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %call2 = call i64 (...) @read()
  %conv = trunc i64 %call2 to i16
  %0 = load ptr, ptr @graph, align 8
  %arrayidx = getelementptr inbounds i16, ptr %0, i64 %i.0
  store i16 %conv, ptr %arrayidx, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add i64 %i.0, 1
  br label %for.cond, !llvm.loop !10

for.end:                                          ; preds = %for.cond.cleanup
  call void @floyd()
  %1 = load i64, ptr @cycle_pos, align 8
  call void @write(i64 noundef %1)
  %2 = load i64, ptr @cycle_len, align 8
  call void @write(i64 noundef %2)
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
