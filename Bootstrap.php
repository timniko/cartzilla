<?php declare(strict_types=1);

namespace Template\cartzilla;

use Smarty;
use JTL\ImageMap;
use JTL\Helpers\Form;
use JTL\Checkout\Bestellung;
use JTL\Helpers\Request;
use JTL\Language\LanguageHelper;
use Illuminate\Support\Collection;
use JTL\Cache\JTLCacheInterface;
use JTL\Catalog\Category\Kategorie;
use JTL\Catalog\Category\KategorieListe;
use JTL\Catalog\Product\Artikel;
use JTL\Catalog\Product\Preise;
use JTL\CheckBox;
use JTL\DB\DbInterface;
use JTL\Filter\Config;
use JTL\Filter\ProductFilter;
use JTL\Helpers\Category;
use JTL\Helpers\Manufacturer;
use JTL\Helpers\Seo;
use JTL\Helpers\Tax;
use JTL\Link\Link;
use JTL\Link\LinkGroupInterface;
use JTL\Media\Image;
use JTL\Media\Image\Product;
use JTL\Session\Frontend;
use JTL\Shop;
use JTL\Staat;
use Smarty_Internal_Data;
use stdClass;

/**
 * Class Bootstrap
 * @package Template\NOVAChild
 */
class Bootstrap extends \Template\NOVA\Bootstrap
{
	private $db;
	private $cache;
	private $lfa_fields;
	private $farbfilter;
    /**
     * @inheritdoc
     */
    public function boot(): void
    {
        parent::boot();
        $this->db = $this->getDB();
				$smarty = $this->getSmarty();
        if ($smarty === null) {
            // this will never happen but it calms the IDE down
            return;
        }
				$this->cache = $this->getCache();
				$this->lfa_fields = array("kLieferadresse", "cAnrede", "cVorname", "cNachname", "cFirma", "cZusatz", "cStrasse", "cHausnummer", "cAdressZusatz", "cPLZ", "cOrt", "cBundesland", "cLand", "cTel", "cMobil", "cMail");
        try {
					$smarty->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getChildCats', [$this, 'getChildCats'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'sliderText', [$this, 'sliderText'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'articleCount', [$this, 'articleCount'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'articleCountManufacturer', [$this, 'articleCountManufacturer'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getFilter', [$this, 'getFilter'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getActiveFilter', [$this, 'getActiveFilter'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_article_kat', [$this, 'get_article_kat'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getBanner', [$this, 'getBanner'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'ratingHelpful', [$this, 'ratingHelpful'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'ratingProCons', [$this, 'ratingProCons'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'checkProductWasPurchased', [$this, 'checkProductWasPurchased'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getAvatar', [$this, 'getAvatar'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getBestellungen', [$this, 'BestellCnt'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getWunschzettel', [$this, 'WunschCnt'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getAdressen', [$this, 'AdressCnt'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'cz_step', [$this, 'cz_step'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getLieferAdressen', [$this, 'getLieferAdressen'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'bestellStatusBadge', [$this, 'bestellStatusBadge'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'blogItemData', [$this, 'blogItemData'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'commentData', [$this, 'commentData'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getBlogCats', [$this, 'getBlogCats'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'splitBlogPosts', [$this, 'splitBlogPosts'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'MusterBewertung', [$this, 'MusterBewertung'])
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'isColorFilter', [$this, 'isColorFilter']);
						/*
						->registerPlugin(Smarty::PLUGIN_FUNCTION, 'gibPreisStringLocalizedSmarty', [$this, 'getLocalizedPrice'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getBoxesByPosition', [$this, 'getBoxesByPosition'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'has_boxes', [$this, 'hasBoxes'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'imageTag', [$this, 'getImgTag'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getCheckBoxForLocation', [$this, 'getCheckBoxForLocation'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'hasCheckBoxForLocation', [$this, 'hasCheckBoxForLocation'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'aaURLEncode', [$this, 'aaURLEncode'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_navigation', [$this, 'getNavigation'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_category_array', [$this, 'getCategoryArray'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_category_parents', [$this, 'getCategoryParents'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'prepare_image_details', [$this, 'prepareImageDetails'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_manufacturers', [$this, 'getManufacturers'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_cms_content', [$this, 'getCMSContent'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_static_route', [$this, 'getStaticRoute'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'hasOnlyListableVariations', [$this, 'hasOnlyListableVariations'])
            ->registerPlugin(Smarty::PLUGIN_MODIFIER, 'has_trans', [$this, 'hasTranslation'])
            ->registerPlugin(Smarty::PLUGIN_MODIFIER, 'trans', [$this, 'getTranslation'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'get_product_list', [$this, 'getProductList'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'captchaMarkup', [$this, 'captchaMarkup'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getStates', [$this, 'getStates'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getDecimalLength', [$this, 'getDecimalLength'])
            ->registerPlugin(Smarty::PLUGIN_MODIFIER, 'seofy', [$this, 'seofy'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getUploaderLang', [$this, 'getUploaderLang'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'getCountry', [$this, 'getCountry'])
            ->registerPlugin(Smarty::PLUGIN_FUNCTION, 'sanitizeTitle', [$this, 'sanitizeTitle']);
						*/
        } catch (\SmartyException $e) {
            throw new \RuntimeException('Problems during smarty instantiation: ' . $e->getMessage());
        }
    }
		
		private function getLFA($kKunde){
			$result = array();
			$field_arr = $this->lfa_fields;
			$encodedProperties = array('cNachname', 'cFirma', 'cZusatz', 'cStrasse');
			$checkForDuplis = array();
			$cryptoService = Shop::Container()->getCryptoService();
			$dbObj = $this->db->executeQuery(
			"SELECT tlieferadresse.*, tbestellung.kBestellung
			FROM tlieferadresse
			LEFT JOIN tbestellung
			ON tlieferadresse.kLieferadresse = tbestellung.kLieferadresse
			WHERE tlieferadresse.kKunde = " . intval($kKunde), 2);
			if(count($dbObj) == 0){
				$dbObj = $this->db->executeQuery("SELECT * FROM trechnungsadresse WHERE kKunde = " . $kKunde, 2);
			}
			foreach($dbObj as $lfa){
				if(!isset($lfa->kBestellung)){
					$lfa->kBestellung = NULL;
				}
				if(!is_null($lfa->kBestellung)){
					$lfa->kLieferadresse = 0;
				}
				$tmp = new stdClass();
				$hash = "";
				foreach($field_arr as $f){
					if(isset($lfa->{$f})){
						if($lfa->{$f} != ""){
							if(in_array($f, $encodedProperties)){
								$lfa->{$f} = \trim($cryptoService->decryptXTEA($lfa->{$f}));
								$hash .= strval($lfa->{$f});
							}else{
								if($f === "cVorname"){
									$hash .= strval($lfa->{$f});
								}
							}
						}
						$tmp->{$f} = $lfa->{$f};
					}else{
						$tmp->{$f} = 0;
					}
				}
				$hash = md5($hash);
				if(!isset($checkForDuplis[$hash])){
					$result[] = $tmp;
					$checkForDuplis[$hash] = "";
				}
			}
			return $result;
		}
		
		public function isColorFilter(array $args, $smarty){
			$result = new stdClass();
			$result->value = false;
			$result->data = array();
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'isColor';
			if(isset($args["kMerkmal"])){
				if(is_null($this->farbfilter)){
					$farbfilter = $this->db->selectSingleRow("cartzilla_config", "tkey", "farbfilter");
					if(!is_null($farbfilter)){
						$this->farbfilter = json_decode($farbfilter->textra);
					}
				}
				if(isset($this->farbfilter->kMerkmal)){
					if(intval($args["kMerkmal"]) === intval($this->farbfilter->kMerkmal)){
						$result->value = true;
						if(isset($args["Werte"])){
							foreach($args["Werte"] as $wert){
								if(isset($this->farbfilter->{"kMerkmalWert_" . $wert->kMerkmalWert})){
									$result->data[$wert->kMerkmalWert] = $this->farbfilter->{"kMerkmalWert_" . $wert->kMerkmalWert};
								}
							}
						}
					}
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function MusterBewertung(array $args, $smarty){
			$langHelper = LanguageHelper::getInstance();
			$result = new stdClass();
			$result->kBewertung = 0;
			$result->kArtikel = 0;
			$result->kKunde = 0;
			$result->kSprache = Shop::getLanguageID();
			$result->cName = "Administrator";
			$result->cTitel = $langHelper->getTranslation("reviewDefaultTitel", "custom");
			$result->cText = $langHelper->getTranslation("reviewDefaultText", "custom");
			$result->nHilfreich = 0;
			$result->nNichtHilfreich = 0;
			$result->nSterne = 5;
			$result->nAktiv = 1;
			$result->dDatum = date("Y-m-d");
			$result->cAntwort = "";
			$result->dAntwortDatum = "";
			$result->Datum = date("d.m.Y");
			$result->AntwortDatum = "";
			$result->rated = "";
			$result->nAnzahlHilfreich = 0;
			$smarty->assign("oBewertung", $result);
		}
		
		public function splitBlogPosts(array $args, $smarty){
			$result = new stdClass();
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'BlogPosts';
			$posts = array();
			if(isset($args['posts'])){
				$posts = $args['posts'];
			}
			$featured = array();
			$rest = array();
			foreach($posts as $post){
				if(count($featured) >= 2){
					$rest[] = $post;
				}else{
					if(!empty($post->getPreviewImage())){
						$featured[] = $post;
					}else{
						$rest[] = $post;
					}
				}
			}
			if(count($featured) < 2){
				$rest = array_merge($featured, $rest);
				$featured = array();
			}else if(count($featured) == 2){
				if(count($rest) <= 0){
					$rest = array_merge($featured, $rest);
					$featured = array();
				}
			}
			$result->featured = $featured;
			$result->rest = $rest;
			$smarty->assign($assignTo, $result);
		}
		
		public function getBlogCats(array $args, $smarty){
			$result = new stdClass();
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'BlogCats';
			$dbObj = $this->db->executeQuery("SELECT tnewskategoriesprache.name, tnewskategorienews.kNewsKategorie, COUNT(tnewskategorienews.kNewsKategorie) AS PostCNT
				FROM tnewskategorienews
				RIGHT JOIN tnews
				ON tnewskategorienews.kNews = tnews.kNews AND tnews.nAktiv = 1
				LEFT JOIN tnewskategoriesprache
				ON tnewskategoriesprache.kNewsKategorie = tnewskategorienews.kNewsKategorie AND tnewskategoriesprache.languageID LIKE " . Shop::getLanguageID() . "
				GROUP BY tnewskategorienews.kNewsKategorie", 2);
			$totalCNT = 0;
			if(isset($dbObj[0]->PostCNT)){
				$tmp = array();
				foreach($dbObj as $cat){
					if(!is_null($cat->name)){
						$tmp[] = $cat;
						$totalCNT += intval($cat->PostCNT);
					}
				}
				$result = $tmp;
			}
			$smarty->assign("BlogCats_totalCNT", $totalCNT);
			$smarty->assign($assignTo, $result);
		}
		
		public function commentData(array $args, $smarty){
			$result = new stdClass();
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'commentData';
			$result->avatar = "";
			if(isset($args["commentItem"])){
				$comment = $args["commentItem"];
				$adminID = $comment->getIsAdmin();
				if($adminID == 0){
					$customerID = $comment->getCustomerID();
					if($customerID > 0){
						$avatar = $this->db->selectSingleRow("cartzilla_config", ["tkey", "tvalue"], ["avatar", $customerID]);
						if(!is_null($avatar)){
							$result->avatar = $avatar->textra;
						}
					}
				}else{
					$avatar = $this->db->selectSingleRow("tadminloginattribut", ["kAdminlogin", "cName"], [$adminID, "useAvatarUpload"]);
					if(!is_null($avatar)){
						$result->avatar = $avatar->cAttribValue;
					}
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function blogItemData(array $args, $smarty){
			$result = new stdClass();
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'entryData';
			$result->avail_imgs = array();
			$result->author = new stdClass();
			$result->dateValidFrom = "";
			if(isset($args["newsItem"])){
				$basic = false;
				if(isset($args["basic"]) && $args["basic"] == true){
					$basic = true;
				}
				if(!$basic){
					$avail_imgs = $args["newsItem"]->getNewsImages(\PFAD_ROOT . \PFAD_NEWSBILDER);
					foreach($avail_imgs as $avail_img){
						if(strpos($avail_img->cDatei, "_preview") !== false){
							continue;
						}
						$result->avail_imgs[] = $avail_img;
					}
				}
				$result->author = $args["newsItem"]->getAuthor();
				$dateValid = $args["newsItem"]->getDateValidFrom();
				if(empty($dateValid)){
					$dateValid = $args["newsItem"]->getDateCreated();
				}
				$result->dateValidFrom = $dateValid->format('d M');
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function bestellStatusBadge(array $args, $smarty){
			$result = "";
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'StatusBadge';
			if(isset($args["Bestellung"])){
				$statusMapping = array(
					"-1" => "danger",
					"1" => "dark",
					"2" => "warning",
					"3" => "info",
					"4" => "success",
					"5" => "accent",
					"7" => "dark"
				);
				$order = new Bestellung(intval($args["Bestellung"]->kBestellung));
				
				if(isset($statusMapping[strval($order->cStatus)])){
					$result = "<span class='badge m-0 bg-" . $statusMapping[strval($order->cStatus)] . "'>";
					$result .= $args["Bestellung"]->Status;
					$result .= "</span>";
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function getLieferAdressen(array $args, $smarty){
			$result = array();
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'LieferAdressen';
			$Kunde = Frontend::getCustomer();
			if(isset($Kunde->kKunde)){
				$result = $this->getLFA($Kunde->kKunde);
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function cz_step(array $args, $smarty){
			$result = "cz";
			$lfa_saved = false;
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'cz_step';
			if(isset($args["step"]) && $args["step"] != ""){
				$result = $args["step"];
				if($result != "login"){
					if(isset($_GET["lieferadressen"]) && $_GET["lieferadressen"] == 1){
						$result = "lieferadressen";
					}else if(isset($_GET["czlfaed"]) && $_GET["czlfaed"] == 1){
						$Kunde = Frontend::getCustomer();
						if(isset($Kunde->kKunde)){
							if(Form::validateToken()){
								$encodedProperties = array('cNachname', 'cFirma', 'cZusatz', 'cStrasse');
								$cyptoService = Shop::Container()->getCryptoService();
								$hash = "";
								$tmp = new stdClass();
								$id = 0;
								if(isset($_POST["id"])){
									$id = intval($_POST["id"]);
									unset($_POST["id"]);
								}
								foreach($_POST as $k=>$v){
									if($k == "email")$k = "mail";
									if($k == "firmazusatz")$k = "zusatz";
									if($k == "adresszusatz")$k = "adressZusatz";
									if($k == "plz")$k = "PLZ";
									$k = "c" . ucfirst($k);
									if(in_array($k, $this->lfa_fields)){
										if(in_array($k, $encodedProperties)){
											$hash .= strval($v);
											$v = $cyptoService->encryptXTEA(\trim((string)($v ?? '')));
										}else{
											if($k === "cVorname"){
												$hash .= strval($v);
											}
										}
										$tmp->{$k} = $v;
									}
								}
								$tmp->kKunde = $Kunde->kKunde;
								if(isset($tmp->cBundesland))$tmp->cBundesland = "";
								if($id == 0){
									$lfa_saved = $this->db->insert('tlieferadresse', $tmp) > 0;
								}else{
									$lfa_saved = $this->db->updateRow('tlieferadresse', ["kLieferadresse", "kKunde"], [$id, intval($Kunde->kKunde)], $tmp) > 0;
								}
							}
						}
						$smarty->assign("lfa_saved", $lfa_saved);
						$result = "lieferadressen";
					}else if(isset($_GET["czlfadl"])){
						$Kunde = Frontend::getCustomer();
						if(isset($Kunde->kKunde)){
							$this->db->deleteRow('tlieferadresse', ["kLieferadresse", "kKunde"], [intval($_GET["czlfadl"]), intval($Kunde->kKunde)]);
						}
						$result = "lieferadressen";
					}
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function AdressCnt(array $args, $smarty){
			$result = 0;
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'AdressCnt';
			$Kunde = Frontend::getCustomer();
			if(isset($Kunde->kKunde)){
				$result = count($this->getLFA($Kunde->kKunde));
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function WunschCnt(array $args, $smarty){
			$result = 0;
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'WunschCnt';
			$Kunde = Frontend::getCustomer();
			if(isset($Kunde->kKunde)){
				$dbObj = $this->db->executeQuery("SELECT COUNT(kWunschliste) as WunschCnt FROM twunschliste WHERE kKunde LIKE " . $Kunde->kKunde, 2);
				if(isset($dbObj[0]->WunschCnt)){
					$result = $dbObj[0]->WunschCnt;
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function BestellCnt(array $args, $smarty){
			$result = 0;
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'BestellCnt';
			$Kunde = Frontend::getCustomer();
			if(isset($Kunde->kKunde)){
				$dbObj = $this->db->executeQuery("SELECT COUNT(kBestellung) as BestellCnt FROM tbestellung WHERE kKunde LIKE " . $Kunde->kKunde, 2);
				if(isset($dbObj[0]->BestellCnt)){
					$result = $dbObj[0]->BestellCnt;
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function getAvatar(array $args, $smarty){
			$result = "";
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'Avatar';
			$kKunde = (isset($args['kKunde']))
				? $args['kKunde']
				: -1;
			$kKunde = intval($kKunde);
			if($kKunde < 0){
				$Kunde = Frontend::getCustomer();
				if(isset($Kunde->kKunde)){
					$kKunde = intval($Kunde->kKunde);
				}
			}
			if($kKunde > 0){
				$avatar = $this->db->selectSingleRow("cartzilla_config", ["tkey", "tvalue"], ["avatar", $kKunde]);
				if(!is_null($avatar)){
					$baseURL = Shop::getImageBaseURL();
					$avatar = $avatar->textra;
					if(substr($baseURL, -1) === "/"){
						if(substr($avatar, 0, 1) === "/"){
							$avatar = substr($avatar, 1);
						}
					}
					$result = $baseURL . $avatar;
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function checkProductWasPurchased(array $args, $smarty){
			$result = false;
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'ProductWasPurchased';
			$aid = (isset($args['aid']) && $args['aid'] != "")
				? $args['aid']
				: "";
			$conf = (isset($args['conf']) && $args['conf'] != "")
				? $args['conf']
				: "Y";
			if($conf === "N" || $aid == ""){
				$result = true;
			}
			if(!$result){
				$customer = Frontend::getCustomer();
				$order = $this->db->getSingleObject(
					'SELECT tbestellung.kBestellung
						FROM tbestellung
						LEFT JOIN tartikel 
							ON tartikel.kVaterArtikel = :aid
						JOIN twarenkorb 
							ON twarenkorb.kWarenkorb = tbestellung.kWarenkorb
						JOIN twarenkorbpos 
							ON twarenkorbpos.kWarenkorb = twarenkorb.kWarenkorb
						WHERE tbestellung.kKunde = :cid
							AND (twarenkorbpos.kArtikel = :aid 
							OR twarenkorbpos.kArtikel = tartikel.kArtikel)',
					['aid' => $aid, 'cid' => $customer->getID()]
				);
				$result = $order !== null && $order->kBestellung > 0;
			}
			$smarty->assign($assignTo, $result);
    }
		
		public function ratingProCons(array $args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'rating_pro_con';
			$txt = (isset($args['txt']) && $args['txt'] != "")
				? $args['txt']
				: "";
			$result = new stdClass();
			$result->txt = $txt;
			$result->pros = "";
			$result->cons = "";
			if($txt != ""){
				preg_match("/{Pros}(.*){\/Pros}/", $txt, $matches);
				if(isset($matches[1])){
					$result->pros = $matches[1];
				}
				unset($matches);
				preg_match("/{Cons}(.*){\/Cons}/", $txt, $matches);
				if(isset($matches[1])){
					$result->cons = $matches[1];
				}
				$txt = preg_replace("/{Pros}.*{\/Pros}/", "", $txt);
				$txt = preg_replace("/{Cons}.*{\/Cons}/", "", $txt);
				$result->txt = $txt;
				
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function ratingHelpful(array $args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'ratingHelpful';
			$reviews = (isset($args['reviews']) && $args['reviews'] != "")
				? $args['reviews']
				: array();
			$result = 0;
			if(!is_array($reviews)){
				$reviews = array($reviews);
			}
			if(count($reviews)){
				foreach($reviews as $review){
					$result += intval($review->nAnzahlHilfreich);
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function getBanner(array $args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'adBanner';
			$nSeitenTyp = (isset($args['nSeitenTyp']) && $args['nSeitenTyp'] != "")
				? $args['nSeitenTyp']
				: NULL;
			$currentCat = (isset($args['currentCat']) && $args['currentCat'] != "")
				? $args['currentCat']
				: NULL;
			$result = array();
			$imageMap = new ImageMap($this->db);
			$banners = $imageMap->fetchAll();
			$filter = Shop::getProductFilter();
			$filterMap = array(
				"kMerkmalWert" => "Characteristic",
				"kHersteller" => "Manufacturer"
			);
			foreach($banners as $banner){
				if($banner->active == 1){
					$tmp = $imageMap->fetch(intval($banner->kImageMap), false, false);
					if($tmp != false){
						$ext = $this->db->select('textensionpoint', 'cClass', 'ImageMap', 'kInitial', intval($banner->kImageMap));
						if(intval($ext->nSeite) == $nSeitenTyp || $nSeitenTyp == 0){
							$skip = false;
							if($ext->cKey != ""){
								$skip = true;
								$cKey = $ext->cKey;
								if(isset($filterMap[$cKey]))$cKey = $filterMap[$cKey];
								$activeFilter = $filter->getActiveFilterByClassName("JTL\Filter\Items\\" . $cKey);
								if(!is_null($activeFilter)){
									if(strval($ext->cValue) == strval($activeFilter->getValue())){
										$skip = false;
									}
								}else{
									if($cKey == "kKategorie" && !is_null($currentCat)){
										if(isset($currentCat->kKategorie)){
											if($ext->cValue == strval($currentCat)){
												$skip = false;
											}
										}
									}
								}
							}
							if(!$skip){
								if(isset($tmp->oArea_arr[0])){
									if($tmp->oArea_arr[0]->cUrl == ""){
										if(isset($tmp->oArea_arr[0]->oArtikel)){
											$tmp->oArea_arr[0]->oArtikel = $tmp->oArea_arr[0]->oArtikel->fuelleArtikel($tmp->oArea_arr[0]->kArtikel);
											$tmp->oArea_arr[0]->cUrl = $tmp->oArea_arr[0]->oArtikel->cURLFull;
										}
									}
								}
								$result[] = $tmp;
							}
						}
					}
				}
			}
			$smarty->assign($assignTo, $result);
		}
		
		private function getActFilter(){
			$result = array();
			$filter = Shop::getProductFilter();
			$activeFilter = $filter->getActiveFilters();
			
			foreach($activeFilter as $acFilter){
				$activeOptions = $acFilter->getActiveValues();
				if(!is_array($activeOptions)){
					$activeOptions = array($activeOptions);
				}
				if($acFilter->getNiceName() == "Characteristic"){
					foreach($activeOptions as $acOption){
						$result[$acFilter->getNiceName() . "-" . $acOption->getName()] = "";
					}
				}else{
					foreach($activeOptions as $acOption){
						$result[$acFilter->getNiceName() . "-" . $acOption->getValue()] = "";
					}
				}
			}
			return $result;
		}
		
		public function getActiveFilter(array $args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'aktiveFilter';
			$result = $this->getActFilter();
			$smarty->assign($assignTo, $result);
		}
		
		public function getChildCats($args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'subCategories';
			$result = new stdClass();
			if(isset($args['catID'])){
				$list = new KategorieListe();
        $result = $list->getChildCategories($args['catID'], Frontend::getCustomerGroup()->getID(), Shop::getLanguageID());
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function get_article_kat($args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'article_kat';
			$result = new stdClass();
			$result->characteristics = array();
			$result->manufacturers = array();
			$result->cName = "";
			$result->cURLFull = "";
			if(isset($args['Artikel'])){
				$cat = new Kategorie($args['Artikel']->gibKategorie());
				$result->cName = $cat->getName();
				$result->cURLFull = $cat->getURL();
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function getFilter($args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'allFilter';
			$result = new stdClass();
			$filter = Shop::getProductFilter();
			
			/* MANUFACTURER */
			$tmp_result = array();
			$manuf = $filter->getManufacturerFilter();
			foreach($manuf->getOptions() as $o){
				$manufacturer = new stdClass();
				$manufacturer->total = $o->getCount();
				$manufacturer->cName = $o->getName();
				$manufacturer->niceName = $o->getNiceName();
				$manufacturer->url = $o->getURL();
				$manufacturer->value = $o->getValue();
				$tmp_result[] = $manufacturer;
			}
			$result->manufacturers = $tmp_result;
			$tmp_result = array();
			
			/* AVAILABILITY */
			$avail = $filter->getAvailabilityFilter();
			foreach($avail->getOptions() as $o){
				$availability = new stdClass();
				$availability->urlParam = $avail->getUrlParam();
				$availability->total = $o->getCount();
				$availability->cName = $o->getName();
				$availability->niceName = $o->getNiceName();
				$availability->url = $o->getURL();
				$availability->value = $o->getValue();
				$tmp_result[] = $availability;
			}
			$result->availability = $tmp_result;
			$tmp_result = array();
			
			/* CHARACTERISTICS */
			$caract = $filter->getCharacteristicFilterCollection();
			if(is_null($this->farbfilter)){
				$farbfilter = $this->db->selectSingleRow("cartzilla_config", "tkey", "farbfilter");
				if(!is_null($farbfilter)){
					$this->farbfilter = json_decode($farbfilter->textra);
				}
			}
			$lastItem = "";
			foreach($caract->getFilterCollection() as $r){
				$fr_name = $r->getFrontendName();
				if(!isset($tmp_result[$fr_name])){
					$tmp_result[$fr_name] = new stdClass();
					$tmp_result[$fr_name]->values = array();
					$fr_id = $r->getValue();
					$tmp_result[$fr_name]->type = "text";
					$tmp_result[$fr_name]->frontendName = $fr_name;
					$tmp_result[$fr_name]->niceName = $r->getNiceName();
					if(isset($this->farbfilter->kMerkmal)){
						if(intval($fr_id) == intval($this->farbfilter->kMerkmal)){
							$tmp_result[$fr_name]->type = "color";
							$lastItem = $fr_name;
						}
					}
				}
				foreach($r->getOptions() as $o){
					$optName = $o->getName();
					$optValue = $o->getValue();
					$optID = NULL;
					$tmp = new stdClass();
					$tmp->wert = $o->getValue();
					$tmp->niceName = $r->getNiceName();
					$tmp->url = $o->getURL();
					$tmp->total = $o->getCount();
					$tmp->attr = "";
					if($tmp_result[$fr_name]->type == "color"){
						$getID = $this->db->selectSingleRow("tmerkmalwertsprache", ["cWert", "kSprache"], [$tmp->wert, Shop::getLanguageID()]);
						if(!is_null($getID)){
							if(isset($this->farbfilter->{"kMerkmalWert_" . $getID->kMerkmalWert})){
								$tmp->attr = $this->farbfilter->{"kMerkmalWert_" . $getID->kMerkmalWert};
							}
						}
					}
					$tmp_result[$fr_name]->values[] = $tmp;
				}
			}
			if($lastItem != ""){
				if(isset($tmp_result[$lastItem])){
					$reAdd = $tmp_result[$lastItem];
					unset($tmp_result[$lastItem]);
					$tmp_result[$lastItem] = $reAdd;
				}
			}
			$result->characteristics = $tmp_result;
			$smarty->assign($assignTo, $result);
		}
		
		public function articleCountManufacturer($args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'man_art_cnt';
			$q_obj = $this->db->getObjects(
				"SELECT thersteller.kHersteller, COUNT(tartikel.kArtikel) as total
				FROM thersteller
				LEFT JOIN tartikel
				ON thersteller.kHersteller = tartikel.kHersteller
				GROUP BY thersteller.kHersteller"
			);
			$result = array();
			foreach($q_obj as $r){
				$result[intval($r->kHersteller)] = $r->total;
			}
			$smarty->assign($assignTo, $result);
		}
		
		public function articleCount($args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'cat_art_cnt';
			
			// GET ALL FROM SUB CATEGORIES !!!
			$q_obj = $this->db->getObjects(
				"SELECT tkategorie.kKategorie, COUNT(case when tartikel.kVaterArtikel=0 then 1 end) as total, tkategorie.kOberKategorie
				FROM tkategorie
				LEFT JOIN tkategorieartikel
				ON tkategorieartikel.kKategorie = tkategorie.kKategorie
				LEFT JOIN tartikel
				ON tartikel.kArtikel = tkategorieartikel.kArtikel
				GROUP BY tkategorie.kKategorie
				ORDER BY tkategorie.kKategorie ASC"
			);
			$result = array();
			$parentKeys = array();
			foreach($q_obj as $r){
				$r->kKategorie = intval($r->kKategorie);
				$r->kOberKategorie = intval($r->kOberKategorie);
				$r->total = intval($r->total);
				$parentKeys[$r->kKategorie] = $r->kOberKategorie;
				if(!isset($result[$r->kKategorie])){
					$result[$r->kKategorie] = 0;
				}
				$result[$r->kKategorie] += $r->total;
				if($r->kOberKategorie > 0){
					if(!isset($result[$r->kOberKategorie])){
						$result[$r->kOberKategorie] = 0;
					}
					$result[$r->kOberKategorie] += $r->total;
					if(isset($parentKeys[$r->kOberKategorie])){
						if(isset($result[$parentKeys[$r->kOberKategorie]])){
							$result[$parentKeys[$r->kOberKategorie]] += $r->total;
						}
					}
				}
			}
			$smarty->assign($assignTo, $result);
		}

		public function sliderText($args, $smarty){
			$assignTo = (isset($args['cAssign']) && \strlen($args['cAssign']) > 0)
				? $args['cAssign']
				: 'h3h2p';
			$result = array("h3" => "", "h2" => "", "p" => "");
			preg_match('/\[h3\](.*)?\[\/h3\]/', $args["text"], $matches);
			if(isset($matches[1]))$result["h3"] = $matches[1];
			preg_match('/\[h2\](.*)?\[\/h2\]/', $args["text"], $matches);
			if(isset($matches[1]))$result["h2"] = $matches[1];
			preg_match('/\[p\](.*)?\[\/p\]/', $args["text"], $matches);
			if(isset($matches[1]))$result["p"] = $matches[1];
			
			$smarty->assign($assignTo, $result);
		}

    protected function registerPlugins(): void
    {
        parent::registerPlugins();
        // whatever you do, always call parent::registerPlugins() or delete this method!
    }
}
