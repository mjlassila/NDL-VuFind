<!-- START of: Content/privacy_policy.sv.tpl -->

{assign var="title" value="Datasekretess"}
{capture append="sections"}
<div class="grid_18">
<h3>Hantering av kunduppgifter i Finna </h3>
<p>När användaren loggar in i Finna med sitt bibliotekskort sparas kortets nummer och pinkod, användarens för- och efternamn, e-postadress och hembibliotek i tjänsten. Om man loggar in med Mozilla Persona sparas bara användarens e-postadress automatiskt i Finna. Vid Haka-inloggning sparas användarnamnet och användarens namn och e-postadress automatiskt i Finna. Uppgifterna används för följande ändamål:</p>

<table class="privacyTable">
  <tr>
	<td><strong>Uppgift</strong></td>
	<td><strong>Ändamål</strong></td>
  </tr>
  <tr>
	<td>Bibliotekskortets nummer</td>
	<td>Identifierar användaren</td>
  </tr>
  <tr>
	<td>Pinkoden</td>
	<td>Identifierar användaren i olika tjänstegränssnitt</td>
  </tr>
  <tr>
	<td>Förnamn</td>
	<td>Identifierar användaren och används för att visa information</td>
  </tr>
  <tr>
	<td>Efternamn</td>
	<td>Identifierar användaren och används för att visa information</td>
  </tr>
  <tr>
	<td>E-postadress</td>
	<td>Den adress som i första hand används, användaren kan ändra uppgiften i Finna</td>
  </tr>
  <tr>
	<td>Hembibliotek</td>
	<td>Det ställe där beställningar i första hand avhämtas, användaren kan ändra uppgiften i Finna</td>
  </tr>
</table>

<p>Till den e-postadress som sparas i Finna skickas bara sådana mejl som användaren själv önskar, t.ex. påminnelser om förfallodag och meddelanden från nyhetsbevakningen.
</p>
<p>
Förutom de ovan nämnda uppgifterna kan man också spara information om användarens aktiviteter i Finna. Sådan information är bl.a. språk, aktiverad påminnelse om förfallodag, nyhetsbevakningar, poster som användaren har sparat i egna listor, bibliotekskort som användaren själv lagt till och sociala metadata (kommentarer, recensioner, nyckelord).
</p>
<p>
För andra funktioner som hanterar användarnas uppgifter används bibliotekssystemets tjänstegränssnitt, t.ex. för funktioner som gäller reserveringar, lån och avgifter, och uppgifterna sparas inte i Finna, med undantag av de frivilliga påminnelserna om förfallodag. I samband med att en påminnelse om förfallodag skickas till användaren sparas id-numret och förfallodagen för lånet, detta för att varje påminnelse bara ska skickas en gång.
</p>
<p>
Finnakonton som skapas med bibliotekskorts-, Mozilla Persona- och Haka-koder är separata, även om de innehåller samma identifikationskod.
Det finns en registerbeskrivning för hanteringen av användaruppgifter: 
</p>
<p>
Det finns en registerbeskrivning för hanteringen av användaruppgifter: <a href="{$url}/Content/register_details">Registerbeskrivning</a>
</p>
</div>
{/capture}
{include file="$module/content.tpl" title=$title sections=$sections}
<!-- END of: Content/privacy_policy.sv.tpl -->