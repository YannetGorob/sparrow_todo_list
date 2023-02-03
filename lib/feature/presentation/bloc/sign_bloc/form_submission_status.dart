abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmitionSucces extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exeption;

  SubmissionFailed(this.exeption);
 }
