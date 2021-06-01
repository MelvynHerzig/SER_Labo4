<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Travail à faire : Compléter les parties <a compléter> de 1 à 10 afin d'obtenir le résultat expliqué dans la vidéo du laboratoire -->
	<!-- !!!!! Nous vous rendons attentif que vous n'avez PAS LE DROIT de modifier le reste du document, mais uniquement ces parties -->

	<!-- ##### A compléter 1 -->
	<!--- Description du document à produire -->
	<xsl:output
    	method          = "html"
    	encoding        = "UTF-8"
    	doctype-public  = "-//W3C//DTD HTML 4.01//EN"
    	doctype-system  = "http://www.w3.org/TR/html4/strict.dtd"
    	indent          = "yes"
    />

	<!-- ##### A compléter 2 -->
	<!-- Début du template depuis la racine -->
	<xsl:template match="/pokedex">

		<html>

			<style>

				button[aria-expanded="true"] {
				  border: 3px solid;
				}

			</style>

			<head>
				<title>Attrapez les tous...</title>

		        <script type="text/javascript" src="js/jquery-3.4.1.min.js" />
		        <script type="text/javascript" src="js/bootstrap.min.js" />
		        <link rel="stylesheet" href="css/bootstrap.min.css" />

			</head>

			<body>

				<div class="container-fluid">

					  <form>
					     <select name="choix_generation" id="choix_generation" class="form-control">
					     	<option value="1">Génération 1</option>
					     	<option value="2">Génération 2</option>
					     	<option value="3">Génération 3</option>
					     	<option value="4">Génération 4</option>
					     	<option value="5">Génération 5</option>
					     	<option value="6">Génération 6</option>
					     	<option value="7">Génération 7</option>
					     </select>
					 </form>

					<div id="accordion">

						<!-- ##### A compléter 3 : Ici, vous devez trouver l'expression XPath à mettre dans l'attribut select 
					                               Le but est de récupérer les types de pokemon en parcourant tous les enfants <type> de tous les pokemons,
					                               mais sans avoir de doublons à la fin, vous ne pouvez pas mettre explicitement ici les types que vous trouver dans le fichier XML
                                                   Conseil : Cherchez une astuce sur internet ! -->
						<xsl:variable name="types" select="//type[not(preceding::*=.)]" /> 

						<xsl:for-each select="$types">

							&#160;<button data-toggle="collapse" role="button" class="btn btn-outline-primary">

								<xsl:attribute name="data-target">
									<xsl:value-of select="concat('#', .)" />
								</xsl:attribute>
								
								<xsl:value-of select="." />
						    
						    </button>

						</xsl:for-each>

						<xsl:for-each select="$types">

							<xsl:variable name="type" select="." />

							<div data-parent="#accordion" class="collapse">

								<xsl:attribute name="id">
									<xsl:value-of select="." />
								</xsl:attribute>

								<!-- ##### A compléter 4 : Ici, vous devez faire appel au template lister_pokemon en lui passant le bon filtre en paramètre -->
								<xsl:call-template name="lister_pokemon">
									<xsl:with-param name="filtre" select="//pokemon[type=$type]"/>
								</xsl:call-template>

							</div>

						</xsl:for-each>

					</div>

				</div>

			</body>

			<!-- Javascript pour le choix de la génération, à ne pas modifier --> 
			<script type="text/javascript">

				generation = $("#choix_generation").val();

				$("[role=pokemon]").hide(1000);
				$("[role=pokemon][generation=" + generation + "]").show(1000);

				$("#choix_generation").change(function() {

					generation = $(this).val();

					$("[role=pokemon]").hide(1000);
					$("[role=pokemon][generation=" + generation + "]").show(1000);



				});
			</script>

		</html>

	<!-- Fin a compléter 2 -->
	</xsl:template>

	<xsl:template name="lister_pokemon">

		<!-- ##### A compléter 6 -->
		<!-- Récupération du filtre -->
		<xsl:param name="filtre" />

		<div class="row">

			<xsl:for-each select="$filtre">

				<!-- ##### A compléter 7 : Vous devez trier les pokemons par la valeur numérique de leur ID -->
				<xsl:sort order="ascending" select="//id"/>
				<xsl:apply-templates select="." />

			</xsl:for-each>

		</div>

	</xsl:template>

	<xsl:template match="pokemon">

		<div class="col-2 mb-2" role="pokemon">

			<xsl:attribute name="generation">

				<!-- ##### A compléter 10 (le plus proprement possible) étant donné les contraintes suivantes : -->

				<xsl:choose>
					<xsl:when test="id &lt; 152">1</xsl:when>
					<xsl:when test="id &lt; 252">2</xsl:when>
					<xsl:when test="id &lt; 387">3</xsl:when>
					<xsl:when test="id &lt; 494">4</xsl:when>
					<xsl:when test="id &lt; 650">5</xsl:when>
					<xsl:when test="id &lt; 722">6</xsl:when>
					<xsl:when test="id &lt; 810">7</xsl:when>
				</xsl:choose>

				<!-- Fin A compléter 10 -->

			</xsl:attribute>

			<div class="card">

				<div class="card-header">

					<h5><xsl:value-of select="concat(id, ' - ', name/french)" /></h5>

				</div>

				<div class="card-body">

					<div class="row">

						<div class="col-12">
							<xsl:apply-templates select="id" />
						</div>

						<div class="col-12">
							<xsl:apply-templates select="base" />
						</div>

					</div>

				</div>

			</div>

		</div>

	</xsl:template>

	<xsl:template match="id">

		<img width="100%">
			<xsl:attribute name="src">./images/<xsl:copy-of select="format-number(text(), '000')"/>.png</xsl:attribute>
			<!-- ^ Ici ^ un attribut à la balise image afin de spécifier la source de l'image. --> 
			<!-- ##### A compléter 8 : Ici, vous devez étudier le dossier images et vous trouverez facilement l'objectif de ce que vous devez faire ici. Indice : Vous devez utiliser une ou plusieurs fonctions de  XSLT-->
       		<!-- NB : La sources d'images utilisées provient de :  https://github.com/fanzeyi/pokemon.json    -->
		</img>

	</xsl:template>

	<!-- ##### A compléter 9 -->
	<xsl:template match="base">
		<table class="table table-stripped">
			
			<tr>
				<td>Points de vie (HP)</td>
				<td><xsl:value-of select="HP" /></td>
			</tr>

			<tr>
				<td>Attaque</td>
				<td><xsl:value-of select="Attack" /></td>
			</tr>

			<tr>
				<td>Defense</td>
				<td><xsl:value-of select="Defense" /></td>
			</tr>

			<tr>
				<td>Vitesse</td>
				<td><xsl:value-of select="Speed" /></td>
			</tr>


		</table>

	<!-- Fin à compléter 9 -->
	</xsl:template>

</xsl:stylesheet>