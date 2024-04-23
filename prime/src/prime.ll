; ModuleID = '.tmp/a.ll'
source_filename = "prime/src/prime.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@primes = external global ptr, align 8
@checked = external global i64, align 8
@tail = external global ptr, align 8

; Function Attrs: nounwind uwtable
define dso_local i64 @check_with_primes(i64 noundef %n) #0 {
entry:
  %0 = load ptr, ptr @primes, align 8
  br label %while.cond

while.cond:                                       ; preds = %cleanup.cont, %entry
  %curr.0 = phi ptr [ %0, %entry ], [ %curr.1, %cleanup.cont ]
  %retval.0 = phi i64 [ 0, %entry ], [ %retval.1, %cleanup.cont ]
  %cmp = icmp ne ptr %curr.0, null
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i64, ptr %curr.0, align 8
  %mul = mul i64 %1, %1
  %cmp1 = icmp ugt i64 %mul, %n
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %cleanup

if.end:                                           ; preds = %while.body
  %rem = urem i64 %n, %1
  %cmp2 = icmp eq i64 %rem, 0
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  br label %cleanup

if.end4:                                          ; preds = %if.end
  %add.ptr = getelementptr inbounds i64, ptr %curr.0, i64 1
  %2 = load i64, ptr %add.ptr, align 8
  %3 = inttoptr i64 %2 to ptr
  br label %cleanup

cleanup:                                          ; preds = %if.end4, %if.then3, %if.then
  %curr.1 = phi ptr [ %curr.0, %if.then ], [ %curr.0, %if.then3 ], [ %3, %if.end4 ]
  %retval.1 = phi i64 [ %retval.0, %if.then ], [ 0, %if.then3 ], [ %retval.0, %if.end4 ]
  %cleanup.dest.slot.0 = phi i32 [ 3, %if.then ], [ 1, %if.then3 ], [ 0, %if.end4 ]
  switch i32 %cleanup.dest.slot.0, label %cleanup5 [
    i32 0, label %cleanup.cont
    i32 3, label %while.end
  ]

cleanup.cont:                                     ; preds = %cleanup
  br label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %cleanup, %while.cond
  br label %cleanup5

cleanup5:                                         ; preds = %while.end, %cleanup
  %retval.2 = phi i64 [ %retval.1, %cleanup ], [ 1, %while.end ]
  ret i64 %retval.2
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i64 @add_primes(i64 noundef %n) #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %if.end5, %entry
  %retval.0 = phi i64 [ 0, %entry ], [ %retval.2, %if.end5 ]
  %0 = load i64, ptr @checked, align 8
  %1 = load i64, ptr @checked, align 8
  %mul = mul i64 %0, %1
  %cmp = icmp ult i64 %mul, %n
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i64, ptr @checked, align 8
  %inc = add i64 %2, 1
  store i64 %inc, ptr @checked, align 8
  %3 = load i64, ptr @checked, align 8
  %call = call i64 @check_with_primes(i64 noundef %3)
  %tobool = icmp ne i64 %call, 0
  br i1 %tobool, label %if.then, label %if.end5

if.then:                                          ; preds = %while.body
  %call1 = call noalias ptr @malloc(i64 noundef 16) #4
  %4 = load i64, ptr @checked, align 8
  store i64 %4, ptr %call1, align 8
  %add.ptr = getelementptr inbounds i64, ptr %call1, i64 1
  store i64 0, ptr %add.ptr, align 8
  %5 = ptrtoint ptr %call1 to i64
  %6 = load ptr, ptr @tail, align 8
  %add.ptr2 = getelementptr inbounds i64, ptr %6, i64 1
  store i64 %5, ptr %add.ptr2, align 8
  store ptr %call1, ptr @tail, align 8
  %7 = load i64, ptr @checked, align 8
  %rem = urem i64 %n, %7
  %cmp3 = icmp eq i64 %rem, 0
  br i1 %cmp3, label %if.then4, label %if.end

if.then4:                                         ; preds = %if.then
  br label %cleanup

if.end:                                           ; preds = %if.then
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then4
  %retval.1 = phi i64 [ 0, %if.then4 ], [ %retval.0, %if.end ]
  %cleanup.dest.slot.0 = phi i32 [ 1, %if.then4 ], [ 0, %if.end ]
  switch i32 %cleanup.dest.slot.0, label %unreachable [
    i32 0, label %cleanup.cont
    i32 1, label %return
  ]

cleanup.cont:                                     ; preds = %cleanup
  br label %if.end5

if.end5:                                          ; preds = %cleanup.cont, %while.body
  %retval.2 = phi i64 [ %retval.1, %cleanup.cont ], [ %retval.0, %while.body ]
  br label %while.cond, !llvm.loop !8

while.end:                                        ; preds = %while.cond
  br label %return

return:                                           ; preds = %while.end, %cleanup
  %retval.3 = phi i64 [ %retval.1, %cleanup ], [ 1, %while.end ]
  ret i64 %retval.3

unreachable:                                      ; preds = %cleanup
  ret i64 0
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nounwind uwtable
define dso_local i64 @is_prime(i64 noundef %n) #0 {
entry:
  %call = call i64 @check_with_primes(i64 noundef %n)
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %return

if.end:                                           ; preds = %entry
  %call1 = call i64 @add_primes(i64 noundef %n)
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i64 [ 0, %if.then ], [ %call1, %if.end ]
  ret i64 %retval.0
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call noalias ptr @malloc(i64 noundef 16) #4
  store ptr %call, ptr @primes, align 8
  %0 = load ptr, ptr @primes, align 8
  store i64 2, ptr %0, align 8
  %1 = load ptr, ptr @primes, align 8
  %add.ptr = getelementptr inbounds i64, ptr %1, i64 1
  store i64 0, ptr %add.ptr, align 8
  %2 = load ptr, ptr @primes, align 8
  store ptr %2, ptr @tail, align 8
  store i64 2, ptr @checked, align 8
  br label %while.body

while.body:                                       ; preds = %cleanup.cont, %entry
  %call1 = call i64 (...) @read()
  %cmp = icmp eq i64 %call1, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %cleanup

if.end:                                           ; preds = %while.body
  %call2 = call i64 @is_prime(i64 noundef %call1)
  call void @write(i64 noundef %call2)
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  %cleanup.dest.slot.0 = phi i32 [ 3, %if.then ], [ 0, %if.end ]
  switch i32 %cleanup.dest.slot.0, label %unreachable [
    i32 0, label %cleanup.cont
    i32 3, label %while.end
  ]

cleanup.cont:                                     ; preds = %cleanup
  br label %while.body, !llvm.loop !9

while.end:                                        ; preds = %cleanup
  ret i32 0

unreachable:                                      ; preds = %cleanup
  ret i32 0
}

declare i64 @read(...) #3

declare void @write(i64 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!9 = distinct !{!9, !7}
