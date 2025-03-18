import 'package:get/get.dart';
import 'package:resto_page/constant/app_string.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        /// ENGLISH
        'en_US': {
          AppString.loginTitleText: "INCOMING ORDERS AND TABLE RESERVATION",
          AppString.loginText: "Log In",
          AppString.forgetPassText: "Forget Password?",
          AppString.yourEmailText: "Your Email",
          AppString.loginEmailText: "Email*",
          AppString.titlePassText: "Password*",
          AppString.subTitlePassText: "Password",
          AppString.sendEmailText: "Send Email",
          AppString.loginHereText: "Login Here",
          AppString.myOrderReservationText: "My Orders and Reservation",
          AppString.quantity: "Qty:",
          AppString.viewAllText: "VIEW ALL",
          AppString.pendingText: "PENDING",
          AppString.acceptedText: "ACCEPTED",
          AppString.rejectedText: "REJECTED",
          AppString.newTestOrderText: "New Test Order",
          AppString.testNewDeliveryOrderText: "Test New Delivery Order",
          AppString.testNewPickUpOrderText: "Test New Pickup Order",
          AppString.testNewReservationText: "Test New Reservation",
          AppString.feedBackTitleText: "Feedback",
          AppString.feedBackSubTitleText:
              "You have some ideas or feedback? Email our development team with your feedback.",
          AppString.sendFeedbackText: "Send Feedback",
          AppString.aboutTitleText: "Privacy Policy",
          AppString.aboutSubTitleText:
              "This is about page content in mobile app.",
          AppString.languageText: "Language",
          AppString.englishText: "English",
          AppString.germanText: "German",
          AppString.frenchText: "French",
          AppString.myAccountText: "My Account",
          AppString.accountDetailsText:
              "Account details can only be modified in web interface.",
          AppString.infoTitleText: "Info",
          AppString.infoSubTitleText:
              "Dont't miss orders! Prevent Android deeep sleep by keeping charger connected at all times.",
          AppString.okGotItText: "Ok, Got it",
          AppString.rejectOrderTitleText: "Reject Order",
          AppString.rejectOrder1Text:
              "1. Call your customer to resolve the issue",
          AppString.rejectOrder2Text: "2. Make this order as rejected",
          AppString.callCustomerText: "Call Customer",
          AppString.rejectTableConservationText: "Reject Order",
          AppString.rejectTableSubText:
              "Your Customer will receive a notification about this action",
          AppString.acceptButtonText: "Accept",
          AppString.rejectButtonText: "Reject",
          AppString.printButtonText: "Print",
          AppString.subTotalText: "Sub Total (Incl Tax)",
          AppString.taxText: "Tax",
          AppString.deliveryCostText: "Delivery Cost (Incl Tax)",
          AppString.discountText: "Discount",
          AppString.totalTaxText: "Total (Incl Tax)",
          AppString.customerReceiveEmailText:
              "Your customer will receive an email stating that his reservation has been confirmed.",
          AppString.accepted2Text: "Accepted",
          AppString.pending2Text: "Pending",
          AppString.rejected2Text: "Canceled",
          AppString.termTitleText: "Terms",
          AppString.orderText: "Orders",
          AppString.settingText: "Settings",
          AppString.printerText: "Printer",
          AppString.accountText: "Account",
          AppString.thermalPrinterText: "Thermal Printer",
          AppString.logOutText: "Logout",
          AppString.somethingWentWrongText: "Something went wrong!",
          AppString.termSubTitleText:
              "This is the content of the Terms and Conditions page in Mobile",
          AppString.pickOrder30MinitueText:
              "This is Test Pickup order,It will be automaticalliy deleted after 30 minitues",
          AppString.acceptText: "Accept",
          AppString.acceptAndConfirmText: "Accept and Confirm",
          AppString.pickUpTimeText: "Pickup Time",
          AppString.deliveryTimeText: "Delivery Time",
          AppString.pickTimeSubText:
              "We will send your customer an email with the pick-up time.",
          AppString.deliveryTimeSubText:
              "We will send your customer an email with the delivery time.",
          AppString.reservationTimeSubText:
              "We will send your customer an email with the reservation time.",
          AppString.min10: "10 Min",
          AppString.min20: "20 Min",
          AppString.min30: "30 Min",
          AppString.min40: "40 Min",
          AppString.min50: "50 Min",
          AppString.min60: "60 Min",
          AppString.min70: "70 Min",
          AppString.min80: "80 Min",
          AppString.min90: "90 Min",
          AppString.minText: "Min",
          AppString.otherText: "Other",
          AppString.youHave20MinutesText:
              "You have to accept or decline within 20 minutes,otherwise the order will ne automatically rejected.",
          AppString.sureLogOutText: "Are you sure to Logout?",
          AppString.cancelText: "Cancel",
          AppString.floorText: "Floor",
          AppString.companyText:"Company"
        },

        /// GERMAN
        'de_GER': {
          AppString.somethingWentWrongText: "Etwas ist schief gelaufen!",
          AppString.loginTitleText: "AUFTRAGSEINGANG UND TISCHRESERVIERUNG",
          AppString.loginText: "Anmeldung",
          AppString.forgetPassText: "Passwort vergessen?",
          AppString.yourEmailText: "Deine E-Mail",
          AppString.loginEmailText: "Email*",
          AppString.titlePassText: "Passwort*",
          AppString.subTitlePassText: "Passwort",
          AppString.sendEmailText: "E-Mail senden",
          AppString.loginHereText: "Hier anmelden",
          AppString.quantity: "Qty:",
          AppString.myOrderReservationText:
              "Meine Bestellungen und Reservierung",
          AppString.viewAllText: "ALLE ANSEHEN",
          AppString.pendingText: "AUSSTEHEND",
          AppString.acceptedText: "AKZEPTIERT",
          AppString.rejectedText: "ABGELEHNT",
          AppString.newTestOrderText: "Neue Testanordnung",
          AppString.testNewDeliveryOrderText:
              "Testen Sie den neuen Lieferauftrag",
          AppString.testNewPickUpOrderText:
              "Testen Sie die neue Abholbestellung",
          AppString.testNewReservationText: "Neue Reservierung testen",
          AppString.feedBackTitleText: "Rückmeldung",
          AppString.feedBackSubTitleText:
              "Sie haben Ideen oder Feedback? Schicken Sie unserem Entwicklungsteam Ihr Feedback per E-Mail.",
          AppString.sendFeedbackText: "Feedback abschicken",
          AppString.aboutTitleText: "Datenschutz",
          AppString.aboutSubTitleText:
              "Hier geht es um Seiteninhalte in mobilen Apps.",
          AppString.languageText: "Sprache",
          AppString.englishText: "Englisch",
          AppString.germanText: "Deutsch",
          AppString.frenchText: "Französisch",
          AppString.myAccountText: "Mein Konto",
          AppString.accountDetailsText:
              "Kontodetails können nur in der Weboberfläche geändert werden.",
          AppString.infoTitleText: "Die Info",
          AppString.infoSubTitleText:
              "Verpassen Sie keine Bestellungen! Verhindern Sie den Tiefschlaf von Android, indem Sie das Ladegerät ständig angeschlossen lassen.",
          AppString.okGotItText: "OK habe es",
          AppString.rejectOrderTitleText: "Bestellung ablehnen",
          AppString.rejectOrder1Text:
              "1. Rufen Sie Ihren Kunden an, um das Problem zu lösen",
          AppString.rejectOrder2Text:
              "2. Machen Sie diese Bestellung zu einer abgelehnten Bestellung",
          AppString.callCustomerText: "Rufen Sie den Kunden an",
          AppString.rejectTableConservationText: "Bestellung ablehnen",
          AppString.rejectTableSubText:
              "Ihr Kunde erhält eine Benachrichtigung über diese Aktion",
          AppString.acceptButtonText: "Akzeptieren",
          AppString.rejectButtonText: "Ablehnen",
          AppString.printButtonText: "Drucken",
          AppString.subTotalText: "Zwischensumme (inkl. Steuern)",
          AppString.taxText: "Steuer",
          AppString.deliveryCostText: "Versandkosten (inkl. Steuern)",
          AppString.discountText: "Rabatt",
          AppString.totalTaxText: "Gesamt (inkl. Steuern)",
          AppString.customerReceiveEmailText:
              "Ihr Kunde erhält eine E-Mail mit der Bestätigung, dass seine Reservierung bestätigt wurde.",
          AppString.accepted2Text: "Akzeptiert",
          AppString.pending2Text: "Ausstehend",
          AppString.rejected2Text: "Abgesagt",
          AppString.termTitleText: "Bedingungen",
          AppString.orderText: "Befehl",
          AppString.settingText: "Einstellungen",
          AppString.printerText: "Drucker",
          AppString.accountText: "Konto",
          AppString.thermalPrinterText: "Thermodrucker",
          AppString.logOutText: "Ausloggen",
          AppString.appVersion: "appVersion",
          AppString.termSubTitleText:
              "Dies ist der Inhalt der Seite „Allgemeine Geschäftsbedingungen“ in Mobile",
          AppString.pickOrder30MinitueText:
              "Dies ist ein Testabholauftrag. Er wird nach 30 Minuten automatisch gelöscht",
          AppString.acceptText: "Akzeptieren",
          AppString.acceptAndConfirmText: "Akzeptieren und bestätigen",
          AppString.pickUpTimeText: "Abholzeit",
          AppString.pickTimeSubText:
              "Wir senden Ihrem Kunden eine E-Mail mit der Abholzeit.",
          AppString.deliveryTimeSubText:
              "Wir senden Ihrem Kunden eine E-Mail mit der Lieferzeit.",
          AppString.reservationTimeSubText:
              "Wir senden Ihrem Kunden eine E-Mail mit der Reservierungszeit.",
          AppString.min10: "10 Minuten",
          AppString.min20: "20 Minuten",
          AppString.min30: "30 Minuten",
          AppString.min40: "40 Minuten",
          AppString.min50: "50 Minuten",
          AppString.min60: "60 Minuten",
          AppString.min70: "70 Minuten",
          AppString.min80: "80 Minuten",
          AppString.min90: "90 Minuten",
          AppString.minText: "Minuten",
          AppString.otherText: "Andere",
          AppString.deliveryTimeText: "Lieferzeit",
          AppString.youHave20MinutesText:
              "Sie müssen die Bestellung innerhalb von 20 Minuten annehmen oder ablehnen, andernfalls wird die Bestellung automatisch abgelehnt.",
          AppString.sureLogOutText: "Möchten Sie sich wirklich abmelden?",
          AppString.cancelText: "Stornieren",
           AppString.floorText: "Boden",
          AppString.companyText:"Unternehmen"
        },

        /// ENGLISH
        'fr_CH': {
          AppString.deliveryTimeText: "Délai de livraison",
          AppString.somethingWentWrongText: "Quelque chose s'est mal passé !",
          AppString.loginTitleText:
              "ENTRÉES DE COMMANDES ET RÉSERVATION DE TABLE",
          AppString.loginText: "Connexion",
          AppString.forgetPassText: "Mot de passe oublié?",
          AppString.yourEmailText: "Votre e-mail",
          AppString.loginEmailText: "E-mail*",
          AppString.titlePassText: "Mot de passe*",
          AppString.subTitlePassText: "Mot de passe",
          AppString.sendEmailText: "Envoyer un e-mail",
          AppString.loginHereText: "Connectez-vous ici",
          AppString.myOrderReservationText: "Mes commandes et réservation",
          AppString.viewAllText: "VOIR TOUT",
          AppString.pendingText: "EN ATTENTE",
          AppString.acceptedText: "ACCEPTÉ",
          AppString.rejectedText: "REJETÉ",
          AppString.newTestOrderText: "Nouvelle commande test",
          AppString.testNewDeliveryOrderText:
              "Tester un nouveau bon de livraison",
          AppString.testNewPickUpOrderText:
              "Tester une nouvelle commande de ramassage",
          AppString.testNewReservationText: "Tester une nouvelle réservation",
          AppString.feedBackTitleText: "Retour",
          AppString.feedBackSubTitleText:
              "Vous avez des idées ou des commentaires? Envoyez un e-mail à notre équipe de développement avec vos commentaires.",
          AppString.sendFeedbackText: "Envoyer des commentaires",
          AppString.aboutTitleText: "Protection des Donnès",
          AppString.aboutSubTitleText:
              "Il s'agit du contenu de la page dans l'application mobile.",
          AppString.languageText: "Langue",
          AppString.englishText: "Anglais",
          AppString.germanText: "Allemand",
          AppString.frenchText: "Français",
          AppString.myAccountText: "Mon compte",
          AppString.accountDetailsText:
              "Les détails du compte ne peuvent être modifiés que dans l'interface Web.",
          AppString.infoTitleText: "Info",
          AppString.infoSubTitleText:
              "Ne manquez pas les commandes ! Empêchez le sommeil profond d'Android en gardant le chargeur connecté à tout moment.",
          AppString.okGotItText: "Ok, j'ai compris",
          AppString.rejectOrderTitleText: "Refuser la commande",
          AppString.rejectOrder1Text:
              "1. Appelez votre client pour résoudre le problème",
          AppString.rejectOrder2Text: "2. Rendre cette commande rejetée",
          AppString.callCustomerText: "Appeler le client",
          AppString.rejectTableConservationText: "Rejeter la commande",
          AppString.rejectTableSubText:
              "Votre client recevra une notification concernant cette action",
          AppString.acceptButtonText: "Accepter",
          AppString.rejectButtonText: "Rejeter",
          AppString.printButtonText: "Imprimer",
          AppString.subTotalText: "Sous-total (TTC)",
          AppString.taxText: "Impôt",
          AppString.deliveryCostText: "Frais de livraison (TTC)",
          AppString.discountText: "Rabais",
          AppString.totalTaxText: "Total (TTC)",
          AppString.customerReceiveEmailText:
              "Votre client recevra un e-mail lui indiquant que sa réservation a été confirmée.",
          AppString.accepted2Text: "Accepté",
          AppString.pending2Text: "En attente",
          AppString.rejected2Text: "Annulé",
          AppString.termTitleText: "Terme",
          AppString.orderText: "Commande",
          AppString.settingText: "Paramètres",
          AppString.printerText: "Imprimant",
          AppString.accountText: "Compte",
          AppString.thermalPrinterText: "Imprimante thermique",
          AppString.logOutText: "Se déconnecter",
          AppString.appVersion: "appVersion",
          AppString.termSubTitleText:
              "Ceci est le contenu de la page Termes et Conditions dans Mobile",
          AppString.pickOrder30MinitueText:
              "Ceci est une commande de ramassage de test, elle sera automatiquement supprimée après 30 minutes",
          AppString.acceptText: "Accepter",
          AppString.acceptAndConfirmText: "Accepter et confirmer",
          AppString.pickUpTimeText: "Heure de ramassage",
          AppString.pickTimeSubText:
              "Nous enverrons à votre client un e-mail avec l'heure de prise en charge.",
          AppString.deliveryTimeSubText:
              "Nous enverrons à votre client un email avec le délai de livraison.",
          AppString.reservationTimeSubText:
              "Nous enverrons à votre client un e-mail avec l'heure de réservation.",
          AppString.min10: "10 Min",
          AppString.min20: "20 Min",
          AppString.min30: "30 Min",
          AppString.min40: "40 Min",
          AppString.min50: "50 Min",
          AppString.min60: "60 Min",
          AppString.min70: "70 Min",
          AppString.min80: "80 Min",
          AppString.min90: "90 Min",
          AppString.minText: "Min",
          AppString.otherText: "Autre",
          AppString.youHave20MinutesText:
              "Vous devez accepter ou refuser la commande dans un délai de 20 minutes, sinon la commande sera automatiquement rejetée.",
          AppString.sureLogOutText: "Voulez-vous vraiment vous déconnecter ?",
          AppString.cancelText: "Annuler",
         AppString.floorText: "Sol",
          AppString.companyText:"Entreprise"
        },
      };
}
