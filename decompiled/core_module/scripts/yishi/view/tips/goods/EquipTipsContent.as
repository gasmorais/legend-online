package yishi.view.tips.goods
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.SuiteTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class EquipTipsContent extends Sprite implements Disposeable
   {
      
      private var _equipIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _addImg:Bitmap;
      
      private var _strengImg:BitmapData;
      
      private var _strengNumSprite:Sprite;
      
      private var _gemSprite:Sprite;
      
      private var _gemVbox:VBox;
      
      private var _refreshVBox:VBox;
      
      private var _refreshTitle:FilterFrameText;
      
      private var _refreshSprite:Sprite;
      
      private var _simpleSuitSkillItem:SkillTipItem;
      
      private var _suitItemSprite:Sprite;
      
      private var _suitSkillSprite:Sprite;
      
      private var _suitSkillVBox:VBox;
      
      private var _title:FilterFrameText;
      
      private var _castSelected:FilterFrameText;
      
      private var _fashionLevel:FilterFrameText;
      
      private var _intensifyText:FilterFrameText;
      
      private var _isActivate:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _contain1:Sprite;
      
      private var _contain2:Sprite;
      
      private var _vocation:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      private var _fashionStr:String = "";
      
      private var _subBox2:VBox;
      
      private var _power:GoodAttributeItem;
      
      private var _agility:GoodAttributeItem;
      
      private var _ability:GoodAttributeItem;
      
      private var _physique:GoodAttributeItem;
      
      private var _captain:GoodAttributeItem;
      
      private var _enchant:GoodAttributeItem;
      
      private var _attack:GoodAttributeItem;
      
      private var _magicAttack:GoodAttributeItem;
      
      private var _defence:GoodAttributeItem;
      
      private var _magicDefence:GoodAttributeItem;
      
      private var _parry:GoodAttributeItem;
      
      private var _live:GoodAttributeItem;
      
      private var _forceHit:GoodAttributeItem;
      
      private var _conat:GoodAttributeItem;
      
      private var _inlayItem1:EquipGemTipItem;
      
      private var _inlayItem2:EquipGemTipItem;
      
      private var _inlayItem3:EquipGemTipItem;
      
      private var _inlayItem4:EquipGemTipItem;
      
      private var _refreshItem1:EquipRefreshTipItem;
      
      private var _refreshItem2:EquipRefreshTipItem;
      
      private var _refreshItem3:EquipRefreshTipItem;
      
      private var _refreshItem4:EquipRefreshTipItem;
      
      private var _refreshItem5:EquipRefreshTipItem;
      
      private var _fashionIdentityTipTxt:EquipRefreshTipItem;
      
      private var _honerTxt01:SkillTipItem;
      
      private var _honerTxt02:SkillTipItem;
      
      private var _skill:FilterFrameText;
      
      private var _subBox3:VBox;
      
      private var _suitTitle:FilterFrameText;
      
      private var _suit1:FilterFrameText;
      
      private var _suit2:FilterFrameText;
      
      private var _suit3:FilterFrameText;
      
      private var _suit4:FilterFrameText;
      
      private var _suit5:FilterFrameText;
      
      private var _suit6:FilterFrameText;
      
      private var _suit7:FilterFrameText;
      
      private var _suit8:FilterFrameText;
      
      private var _suitSkill1:EquipSuitSkillItem;
      
      private var _suitSkill2:EquipSuitSkillItem;
      
      private var _suitSkill3:EquipSuitSkillItem;
      
      private var _suitSkill4:EquipSuitSkillItem;
      
      private var _suitSkill5:EquipSuitSkillItem;
      
      private var _suitSkill6:EquipSuitSkillItem;
      
      private var _suitSkill7:EquipSuitSkillItem;
      
      private var _suitSkill8:EquipSuitSkillItem;
      
      private var _describe:FilterFrameText;
      
      private var _showIcon:Boolean = false;
      
      private var _mouldGrade:int;
      
      private var _gemTxt:FilterFrameText;
      
      private var _baseLine:Bitmap;
      
      private var _attributeLine:Bitmap;
      
      private var _gemLine:Bitmap;
      
      private var _refreshLine:Bitmap;
      
      private var _suitLine:Bitmap;
      
      private const TEMPLATE_NAME_LIST:Vector.<String> = new <String>["Power","Agility","Intellect","Captain","Physique","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Live","Conat","Parry","Penetrate","StunAttr","Strength","Tenacity"];
      
      public var b:Boolean;
      
      public function EquipTipsContent()
      {
         super();
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _addImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         _strengNumSprite = new Sprite();
         _strengNumSprite.y = 11;
         _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         _gemSprite = new Sprite();
         _gemTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText");
         _refreshSprite = new Sprite();
         _refreshTitle = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _castSelected = ComponentFactory.Instance.creatComponentByStylename("tips.castSelectedTxt");
         _fashionLevel = ComponentFactory.Instance.creatComponentByStylename("tips.FashionLevelText");
         _intensifyText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodIntensifyText_2");
         _isActivate = ComponentFactory.Instance.creatComponentByStylename("tips.EquipContent.IsActivateTxt");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox3 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox3");
         _vocation = ComponentFactory.Instance.creatComponentByStylename("tips.GoodVocationText");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText");
         _skill = ComponentFactory.Instance.creatComponentByStylename("tips.GoodSkillText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         _bindText.x = -3;
         _subBox1.spacing = 8;
         _subBox2.spacing = 8;
         _subBox3.spacing = 8;
         _contain1 = new Sprite();
         _contain1.addChild(_vocation);
         _contain1.addChild(_type);
         _contain2 = new Sprite();
         _subBox1.addChild(_contain1);
         _subBox1.addChild(_contain2);
         _baseLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _attributeLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _gemLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _refreshLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _suitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _simpleSuitSkillItem = new SkillTipItem();
         _power = new GoodAttributeItem();
         _agility = new GoodAttributeItem();
         _ability = new GoodAttributeItem();
         _physique = new GoodAttributeItem();
         _captain = new GoodAttributeItem();
         _enchant = new GoodAttributeItem();
         _attack = new GoodAttributeItem();
         _magicAttack = new GoodAttributeItem();
         _defence = new GoodAttributeItem();
         _magicDefence = new GoodAttributeItem();
         _parry = new GoodAttributeItem();
         _live = new GoodAttributeItem();
         _forceHit = new GoodAttributeItem();
         _conat = new GoodAttributeItem();
         _gemSprite.addChild(_gemTxt);
         _gemTxt.width = 130;
         _gemVbox = new VBox();
         _gemSprite.addChild(_gemVbox);
         _gemVbox.y = 25;
         _gemVbox.x = 5;
         _refreshVBox = new VBox();
         _refreshVBox.y = 18;
         _refreshSprite.addChild(_refreshTitle);
         _refreshSprite.addChild(_refreshVBox);
         _inlayItem1 = new EquipGemTipItem();
         _inlayItem2 = new EquipGemTipItem();
         _inlayItem3 = new EquipGemTipItem();
         _inlayItem4 = new EquipGemTipItem();
         _refreshItem1 = new EquipRefreshTipItem();
         _refreshItem2 = new EquipRefreshTipItem();
         _refreshItem3 = new EquipRefreshTipItem();
         _refreshItem4 = new EquipRefreshTipItem();
         _refreshItem5 = new EquipRefreshTipItem();
         _fashionIdentityTipTxt = new EquipRefreshTipItem();
         _suitItemSprite = new Sprite();
         _suitTitle = ComponentFactory.Instance.creatComponentByStylename("tips.SuitTitleText");
         _suit1 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit1.x = 0;
         _suit1.y = 18;
         _suit2 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit2.x = 160;
         _suit2.y = 18;
         _suit3 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit3.x = 0;
         _suit3.y = 36;
         _suit4 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit4.x = 160;
         _suit4.y = 36;
         _suit5 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit5.x = 0;
         _suit5.y = 54;
         _suit6 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit6.x = 160;
         _suit6.y = 54;
         _suit7 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit7.x = 0;
         _suit7.y = 72;
         _suit8 = ComponentFactory.Instance.creatComponentByStylename("tips.SuitItemText");
         _suit8.x = 160;
         _suit8.y = 72;
         _suitSkillSprite = new Sprite();
         _suitSkillVBox = new VBox();
         _suitSkillSprite.addChild(_suitSkillVBox);
         _suitSkill1 = new EquipSuitSkillItem();
         _suitSkill2 = new EquipSuitSkillItem();
         _suitSkill3 = new EquipSuitSkillItem();
         _suitSkill4 = new EquipSuitSkillItem();
         _suitSkill5 = new EquipSuitSkillItem();
         _suitSkill6 = new EquipSuitSkillItem();
         _suitSkill7 = new EquipSuitSkillItem();
         _suitSkill8 = new EquipSuitSkillItem();
         _honerTxt01 = new SkillTipItem();
         _honerTxt02 = new SkillTipItem();
         addChild(_equipIcon);
         addChild(_profileImg);
         _profileImg.setFrame(1);
         addChild(_addImg);
         addChild(_strengNumSprite);
         addChild(_title);
         addChild(_castSelected);
         addChild(_fashionLevel);
         _fashionLevel.visible = false;
         addChild(_totalBox);
         _totalBox.y = 17;
         _fashionLevel.y = 16;
         _describe.width = 320;
      }
      
      public function set showIcon(param1:Boolean) : void
      {
         _showIcon = param1;
      }
      
      protected function initBase(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         _title.setFrame(param2.Profile);
         _title.text = param2.TemplateName;
         if(param2.StrengthenMax > 0 && param2.Profile >= 5 && param2.NeedGrades >= 50)
         {
            if(param1.mouldRank > 16)
            {
               _castSelected.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text4",param1.mouldRankShow,param1.mouldStar);
               _castSelected.setFrame(2);
            }
            else if(param1.mouldRank > 8)
            {
               _castSelected.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text3",param1.mouldRankShow,param1.mouldStar);
               _castSelected.setFrame(2);
            }
            else
            {
               _castSelected.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text2",param1.mouldRankShow,param1.mouldStar);
               _castSelected.setFrame(2);
            }
         }
         else
         {
            _castSelected.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.castSelected.text1");
            _castSelected.setFrame(1);
         }
         if(param2.MasterType == 1)
         {
            if(!GoodsCheck.isFashion(param2))
            {
               _castSelected.visible = true;
            }
            else
            {
               _castSelected.visible = false;
            }
         }
         else
         {
            _castSelected.visible = false;
         }
         _equipIcon.icon = IconFactory.getGoodsIconByTID(param2.TemplateId);
         _equipIcon.visible = true;
         _totalBox.y = 63;
         _profileImg.setFrame(param2.Profile);
         if(param1.strengthenGrade > 0 && param2.MasterType != 5)
         {
            _addImg.visible = true;
            _strengNumSprite.visible = true;
            setStrengNum(param1.strengthenGrade);
            _title.width = 145;
         }
         else if(param2.MasterType == 5 && param1.mouldGrade > 0)
         {
            _addImg.visible = true;
            _strengNumSprite.visible = true;
            setStrengNum(param1.mouldGrade);
            _title.width = 145;
         }
         else
         {
            _addImg.visible = false;
            _strengNumSprite.visible = false;
            _title.width = 163;
         }
         _addImg.x = _title.x + (145 - _title.textWidth) / 2 + _title.textWidth + 2;
         _fashionLevel.x = 125;
         _title.y = 15 - (_title.numLines - 1) * 7.5;
         _strengNumSprite.x = _addImg.x + 15;
         if(FrameControllerManager.instance.fashionCodeController.model.isFashion(param1) && param1.id != 0)
         {
            _fashionLevel.visible = true;
            if(getFashionLevelByInfo(param1) == 12)
            {
               _fashionLevel.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.fashionFullLevel");
            }
            else
            {
               _fashionLevel.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.fashionLevel") + " " + getFashionLevelByInfo(param1);
            }
         }
         else
         {
            _fashionLevel.visible = false;
         }
         _intensifyText.text = param1.templateInfo.StrengthenMax == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.intensify",param1.templateInfo.StrengthenMax);
         _isActivate.text = LanguageMgr.GetTranslation("mountTip.IsActivateTxt");
         _vocation.setFrame(1);
         if(param2.MasterType != 5 && param2.MasterType != 6)
         {
            if(param2.SonType == 117 || param2.SonType == 118)
            {
               if(param2.NeedChangeJob == 2)
               {
                  _vocation.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text5");
                  if(!thane.isAvenger)
                  {
                     _vocation.setFrame(2);
                  }
               }
               else
               {
                  _vocation.text = LanguageMgr.GetTranslation("HigherGradeOpenTipView.content31");
                  if(thane.vocationGrades <= 0)
                  {
                     _vocation.setFrame(2);
                  }
               }
            }
            else if(param2.NeedChangeJob == 1)
            {
               _vocation.text = LanguageMgr.GetTranslation("EquipTipsContent.needChangeJob");
               if(!thane.isChangeJob)
               {
                  _vocation.setFrame(2);
               }
            }
            else if(param2.NeedChangeJob == 2)
            {
               _vocation.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text5");
               if(!thane.isAvenger)
               {
                  _vocation.setFrame(2);
               }
            }
            else
            {
               _vocation.text = param2.jobName + " " + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.grade",param2.NeedGrades);
               if(param2.NeedGrades > thane.grades)
               {
                  _vocation.setFrame(2);
               }
            }
         }
         else if(param2.MasterType == 5)
         {
            _vocation.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.PetVocationTxt0" + param2.Profile);
            if(!thane.enterWarPet || thane.enterWarPet.quality < param2.Profile)
            {
               _vocation.setFrame(2);
            }
         }
         else if(param2.MasterType == 6)
         {
            _vocation.text = ChildManager.instance.getJobName(parseInt(param2.Job));
            if(param2.Profile == 5)
            {
               _vocation.x = 50;
               _vocation.width = 218;
            }
            else
            {
               _vocation.x = 80;
               _vocation.width = 185;
            }
            if(!ChildManager.instance.model.getEnterWar() || ChildManager.instance.model.getEnterWar().growthGp < param2.Property3)
            {
               _vocation.setFrame(2);
            }
         }
         if(param2.MasterType != 6 && !GoodsCheck.isJobFix(thane,param2,false))
         {
            _vocation.textColor = 16711680;
         }
         var _loc3_:String = param2.sonTypeName;
         if(param2.Job == "99")
         {
            _type.width = 180;
            _type.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.dragontalker") + _loc3_;
         }
         else
         {
            _type.width = 200;
            _type.text = _loc3_;
         }
         if(!GoodsCheck.isGradeFix(thane,param2,false))
         {
            _grade.textColor = 16711680;
         }
         if(param1.isBinds)
         {
            _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
            _bindText.setFrame(1);
         }
         else
         {
            _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
            _bindText.setFrame(2);
         }
         _describe.text = param2.Description;
         _describe.height = _describe.textHeight + _describe.numLines * 4;
      }
      
      private function getFashionLevelByInfo(param1:GoodsInfo) : int
      {
         var _loc2_:int = param1.randomSkill1;
         if(!TempleteManager.instance.getSkillTemplateInfoById(param1.randomSkill1))
         {
            _loc2_ = int(param1.templateInfo.DefaultSkill.split(",")[0]);
         }
         return TempleteManager.instance.getSkillTemplateInfoById(_loc2_).Grades;
      }
      
      private function initAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         updateAttributeTxt(_power,_loc3_,param2.Power,getAdd(param2.Power,param1),getNewAdd(param2.Power,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         updateAttributeTxt(_agility,_loc3_,param2.Agility,getAdd(param2.Agility,param1),getNewAdd(param2.Agility,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         updateAttributeTxt(_ability,_loc3_,param2.Intellect,getAdd(param2.Intellect,param1),getNewAdd(param2.Intellect,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         updateAttributeTxt(_physique,_loc3_,param2.Physique,getAdd(param2.Physique,param1),getNewAdd(param2.Physique,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         updateAttributeTxt(_captain,_loc3_,param2.Captain,getAdd(param2.Captain,param1),getNewAdd(param2.Captain,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_attack,_loc3_,param2.Attack,getAdd(param2.Attack,param1),getNewAdd(param2.Attack,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_magicAttack,_loc3_,param2.MagicAttack,getAdd(param2.MagicAttack,param1),getNewAdd(param2.MagicAttack,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_defence,_loc3_,param2.Defence,getAdd(param2.Defence,param1),getNewAdd(param2.Defence,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_magicDefence,_loc3_,param2.MagicDefence,getAdd(param2.MagicDefence,param1),getNewAdd(param2.MagicDefence,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         updateAttributeTxt(_parry,_loc3_,param2.Parry,getAdd(param2.Parry,param1),getNewAdd(param2.Parry,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         updateAttributeTxt(_live,_loc3_,param2.Live,getAdd(param2.Live,param1),getNewAdd(param2.Live,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         updateAttributeTxt(_forceHit,_loc3_,param2.ForceHit,getAdd(param2.ForceHit,param1),getNewAdd(param2.ForceHit,param1),param1.objectId);
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         updateAttributeTxt(_conat,_loc3_,param2.Conat,getAdd(param2.Conat,param1),getNewAdd(param2.Conat,param1),param1.objectId);
      }
      
      private function getNewAdd(param1:int, param2:GoodsInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.templateId);
         if(_loc3_.StrengthenMax > 0 && _loc3_.Profile >= 5 && _loc3_.NeedGrades >= 50 && _loc3_.MasterType != 5)
         {
            if(param2.mouldGrade > 0)
            {
               return GoodsHelp.getMouldAddition(param1,getPropertyMouldGrade(param2));
            }
         }
         return -1;
      }
      
      private function getPropertyMouldGrade(param1:GoodsInfo) : int
      {
         if(_mouldGrade < 1)
         {
            return 1;
         }
         if(_mouldGrade > param1.MOULD_MAX_GRADE)
         {
            return param1.MOULD_MAX_GRADE;
         }
         return _mouldGrade;
      }
      
      private function setStrengNum(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,15,19,"0123456789");
      }
      
      private function initInlay(param1:GoodsInfo) : void
      {
         var _loc6_:String = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc5_:int = 1;
         var _loc4_:Boolean = FrameControllerManager.instance.fashionCodeController.model.isFashion(param1);
         var _loc3_:int = 0;
         if(param1.id == 0)
         {
            _bindText.visible = false;
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId).Property1;
            if(_loc4_)
            {
               _loc3_ = 0;
            }
            _loc5_ = 1;
            while(_loc5_ <= _loc3_)
            {
               _loc6_ = "_inlayItem" + _loc5_;
               if(this.hasOwnProperty(_loc6_) && this[_loc6_] != null)
               {
                  this[_loc6_].setData(0,0);
                  _gemVbox.addChild(this[_loc6_]);
               }
               _loc5_++;
            }
            if(_gemVbox.numChildren > 0)
            {
               if(TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId).MasterType != 5)
               {
                  if(param1.isViceEquip)
                  {
                     _gemTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.gemAdd03");
                  }
                  else
                  {
                     _gemTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.gemAdd");
                  }
               }
               else
               {
                  _gemTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.gemAdd02");
               }
               _subBox3.addChild(_gemSprite);
            }
         }
         else
         {
            _contain2.addChild(_bindText);
            _bindText.visible = true;
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId);
            if(param1 && _loc2_ && _loc2_.StrengthenMax > 0)
            {
               if(param1.isViceEquip)
               {
                  if(param1.templateInfo.Profile >= 4)
                  {
                     _loc3_ = 4;
                  }
                  else
                  {
                     _loc3_ = 3;
                  }
               }
               else if(param1.templateInfo.Profile >= 5)
               {
                  _loc3_ = 4;
               }
               else
               {
                  _loc3_ = 3;
               }
            }
            if(_loc4_)
            {
               _loc3_ = 0;
            }
            _loc5_ = 1;
            while(_loc5_ <= _loc3_)
            {
               _loc6_ = "_inlayItem" + _loc5_;
               this[_loc6_].setData(param1["join" + _loc5_],param1.objectId);
               _gemVbox.addChild(this[_loc6_]);
               _loc5_++;
            }
            if(_gemVbox.numChildren > 0)
            {
               if(TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId).MasterType != 5)
               {
                  if(param1.isViceEquip)
                  {
                     _gemTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.gemAdd03");
                  }
                  else
                  {
                     _gemTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.gemAdd");
                  }
               }
               else
               {
                  _gemTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.gemAdd02");
               }
               _subBox3.addChild(_gemSprite);
               _subBox3.addChild(_gemLine);
            }
         }
      }
      
      private function initEnchant(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         if(param1.enchantSkillId)
         {
            _subBox2.addChild(_enchant);
            _enchant.enchantUpdateText(param1,param2);
         }
      }
      
      private function initSkill(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc9_:int = 0;
         var _loc11_:SkillTempInfo = null;
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         _skill.htmlText = "";
         var _loc12_:String = "";
         var _loc8_:String = "";
         var _loc3_:Boolean = false;
         _loc9_ = 1;
         while(_loc9_ < 6)
         {
            _loc8_ += param1["randomSkill" + _loc9_] + ",";
            if(param1["randomSkill" + _loc9_] != 0)
            {
               _loc3_ = true;
            }
            _loc9_++;
         }
         if(_loc3_ == false)
         {
            _loc8_ = param1.templateInfo.DefaultSkill;
         }
         if(param1.templateInfo.MasterType == 3)
         {
            _loc12_ += LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip23",param1.templateInfo.Strength) + "\n";
            _loc12_ = _loc12_ + (LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip24",param1.templateInfo.Tenacity) + "\n");
            _subBox2.addChild(_honerTxt01);
            _honerTxt01.setSkillTxt(LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip23",param1.templateInfo.Strength));
            _subBox2.addChild(_honerTxt02);
            _honerTxt02.setSkillTxt(LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip24",param1.templateInfo.Tenacity));
         }
         var _loc5_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc8_);
         if(isFashion(param2))
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length)
            {
               _loc11_ = _loc5_[_loc9_] as SkillTempInfo;
               if(_loc11_)
               {
                  _loc12_ += _loc11_.TemplateName + "\n";
                  _loc10_ = getConciseValueStr(_loc11_,param1.objectId);
                  _loc7_ = "";
                  if(getIndex(param1.templateInfo) > -1 && getIndex(param1.templateInfo) == _loc9_)
                  {
                     _loc4_ = setFashionAtt(param1);
                     if(_loc4_ != "")
                     {
                        this["_refreshItem" + (_loc9_ + 1)].setData(_loc7_ + _loc4_ + _loc10_);
                     }
                     else
                     {
                        this["_refreshItem" + (_loc9_ + 1)].setData(_loc7_ + _loc10_);
                     }
                     _refreshVBox.addChild(this["_refreshItem" + (_loc9_ + 1)]);
                  }
                  else
                  {
                     this["_refreshItem" + (_loc9_ + 1)].setData(_loc7_ + _loc10_);
                  }
               }
               _loc9_++;
            }
            _refreshVBox.y = 0;
         }
         else
         {
            if(param1.isViceEquip)
            {
               _refreshTitle.text = GoodsHelp.getGoodQualityName(param1.refreshProfile) + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.refreshAdd");
            }
            else
            {
               _refreshTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.refreshAdd");
            }
            _refreshSprite.addChild(_refreshTitle);
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length)
            {
               _loc11_ = _loc5_[_loc9_] as SkillTempInfo;
               if(_loc11_)
               {
                  _loc10_ = getConciseValueStr(_loc11_,param1.objectId);
                  if(_loc11_.Parameter3 <= 0)
                  {
                     _loc6_ = LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc11_.Grades);
                  }
                  else
                  {
                     _loc6_ = LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades2",_loc11_.Grades);
                  }
                  this["_refreshItem" + (_loc9_ + 1)].setData(_loc11_.TemplateName + _loc6_ + "<font color=\'#00fffc\'>" + _loc10_ + "</font>");
                  _refreshVBox.addChild(this["_refreshItem" + (_loc9_ + 1)]);
               }
               _loc9_++;
            }
            _refreshVBox.y = 18;
         }
         if(param1.id == 0 && !_skill.htmlText && param1.templateInfo.RandomSkillCount != 0)
         {
            _loc12_ += "<" + param1.templateInfo.RandomSkillCount + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.RandomSkillCount") + ">\n";
         }
         if(_loc12_)
         {
            _loc12_ = _loc12_.substr(0,_loc12_.length - 1);
         }
         if(_refreshVBox.numChildren > 0 && param1.templateInfo.MasterType != 3)
         {
            if(param1.isViceEquip)
            {
               _refreshTitle.width = _refreshTitle.textWidth + 10;
            }
            else
            {
               _refreshTitle.width = _refreshTitle.textWidth + 10;
            }
            if(GoodsCheck.isFashion(param1.templateInfo))
            {
               _refreshVBox.y = 0;
            }
            else
            {
               _refreshVBox.y = 18;
            }
            _skill.htmlText = _loc12_;
            _skill.height = _skill.textHeight + 7;
            _subBox3.addChild(_refreshSprite);
            _subBox3.addChild(_refreshLine);
         }
         else if(param1.templateInfo.MasterType == 3)
         {
            if(_attributeLine && _attributeLine.parent)
            {
               _attributeLine.parent.removeChild(_attributeLine);
            }
            if(_refreshTitle && _refreshTitle.parent)
            {
               _refreshTitle.parent.removeChild(_refreshTitle);
            }
            _refreshVBox.y = 0;
            _subBox3.addChild(_refreshSprite);
            _subBox3.addChild(_refreshLine);
         }
      }
      
      private function getConciseValueStr(param1:SkillTempInfo, param2:int) : String
      {
         var _loc7_:SkillPropertyTempInfo = null;
         var _loc8_:* = 0;
         var _loc3_:String = null;
         var _loc4_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:String = "";
         if(param2 == thane.id)
         {
            _loc7_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param1.TemplateId);
            if(!_loc7_)
            {
               return _loc5_;
            }
            _loc4_ = TEMPLATE_NAME_LIST.length;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc3_ = TEMPLATE_NAME_LIST[_loc6_];
               _loc8_ = uint(_loc7_[_loc3_]);
               if(_loc8_ > 0 && getConciseValue(_loc8_) > 0)
               {
                  _loc5_ += "  +" + getConciseValue(_loc8_) + " ";
               }
               _loc6_++;
            }
         }
         return _loc5_;
      }
      
      private function getConciseValue(param1:int) : int
      {
         return GoodsHelp.getConciseValue(param1,thane.conciseGrades);
      }
      
      private function isFashion(param1:GoodsTemplateInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.SonType == 109 || param1.SonType == 112 || param1.SonType == 110 || param1.SonType == 111)
         {
            return true;
         }
         return false;
      }
      
      private function initMould(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
      }
      
      private function initSuit(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc7_:int = 0;
         var _loc4_:ThaneInfo = null;
         var _loc3_:int = 0;
         var _loc11_:Array = null;
         var _loc8_:FilterFrameText = null;
         var _loc9_:int = 0;
         var _loc10_:GoodsTemplateInfo = null;
         var _loc12_:Boolean = false;
         var _loc6_:String = "";
         var _loc5_:SuiteTempInfo = TempleteManager.instance.suitTemplateCate.getTemplateByID(param2.SuiteId);
         if(_loc5_)
         {
            _loc7_ = param1.objectId;
            _loc4_ = ArmyManager.instance.thane;
            if(_loc4_.id == _loc7_)
            {
               if(param1.bagType == 4)
               {
                  _loc11_ = GoodsManager.instance.getHeroEquipListById(_loc7_).getList();
               }
               else if(param1.bagType == 3)
               {
                  _loc11_ = GoodsManager.instance.getHeroHonorListById(_loc7_).getList();
               }
               _loc3_ = _loc5_.existCount(_loc11_);
            }
            else
            {
               _loc3_ = param1.suitCount;
            }
            _suitTitle.text = _loc5_.TemplateName + "(" + (_loc3_ > 0 ? _loc3_ : 0) + "/" + _loc5_.suitCount + ")";
            if(_loc5_.suitCount > 1)
            {
               _suitItemSprite.addChild(_suitTitle);
            }
            _loc9_ = 1;
            while(_loc9_ < 9)
            {
               _loc10_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_["Template" + _loc9_]);
               param1 = GoodsManager.instance.getGoodsByObjectIdAndGoodID(_loc7_,_loc5_["Template" + _loc9_]);
               if(!param1)
               {
                  param1 = GoodsManager.instance.getGoodsByObjectIdAndGoodID(_loc7_,_loc5_["Template" + _loc9_ + "s"]);
               }
               if(_loc10_)
               {
                  _loc8_ = this["_suit" + _loc9_] as FilterFrameText;
                  _loc8_.text = _loc10_.TemplateName;
                  _loc8_.setFrame(1);
                  if(_loc5_.suitCount > 1)
                  {
                     _suitItemSprite.addChild(_loc8_);
                  }
                  if(param1 && _loc3_ > 0)
                  {
                     _loc8_.setFrame(2);
                  }
                  _loc6_ += _loc5_["Property" + _loc9_] + ",";
               }
               _loc9_++;
            }
            _loc12_ = false;
            if(_loc5_.Property1 > 0)
            {
               _loc12_ = true;
            }
            if(_suitItemSprite.numChildren > 2)
            {
               _subBox3.addChild(_suitItemSprite);
            }
            initSuitSkill(_loc5_.suitCount,_loc6_,_loc3_,_loc12_,param1);
         }
      }
      
      private function initSuitSkill(param1:int, param2:String, param3:int, param4:Boolean = false, param5:GoodsInfo = null) : void
      {
         var _loc9_:EquipSuitSkillItem = null;
         var _loc8_:int = 0;
         var _loc10_:SkillTempInfo = null;
         var _loc7_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(param2);
         var _loc6_:String = "";
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc10_ = _loc7_[_loc8_];
            if(_loc10_)
            {
               _loc9_ = this["_suitSkill" + (_loc8_ + 1)];
               if(param1 > 1)
               {
                  _loc9_.setData("(" + (_loc8_ + 1) + ")" + _loc10_.TemplateName);
                  _loc6_ = "(" + (_loc8_ + 1) + ")" + _loc10_.TemplateName;
               }
               else
               {
                  _loc9_.setData(_loc10_.TemplateName);
                  _loc6_ = _loc10_.TemplateName;
               }
               _loc9_.setFrame(2);
               if(param1 <= 1 || _loc8_ < param3)
               {
                  _loc9_.setFrame(1);
               }
               if(param4)
               {
                  _subBox2.addChild(_simpleSuitSkillItem);
                  _simpleSuitSkillItem.setSkillTxt(_loc6_);
                  _loc9_.setFrame(2);
               }
               else
               {
                  _suitSkillVBox.addChild(_loc9_);
               }
            }
            _loc8_++;
         }
         if(_suitSkillVBox.numChildren > 0)
         {
            _subBox3.addChild(_suitSkillSprite);
            _subBox3.addChild(_suitLine);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function updateAttributeTxt(param1:GoodAttributeItem, param2:String, param3:Number, param4:Number, param5:Number, param6:int) : void
      {
         if(param3 != 0)
         {
            param1.updateText(param2,param3,param4,param5,param6);
            _subBox2.addChild(param1);
         }
      }
      
      private function getAdd(param1:int, param2:GoodsInfo) : int
      {
         if(TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.templateId).MasterType == 5)
         {
            return GoodsHelp.getPetEquipStrengAddition(param1,param2.mouldGrade);
         }
         if(TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.templateId).MasterType == 6)
         {
            return GoodsHelp.getChildEquipStrengAddition(param1,param2.strengthenGrade);
         }
         return GoodsHelp.getStrengthenAddition(param1,param2.strengthenGrade);
      }
      
      private function getStrengthenGrade(param1:GoodsInfo) : Object
      {
         return param1.strengthenGrade > 0 ? "+" + param1.strengthenGrade : "";
      }
      
      protected function initData(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         initBase(param1,param2);
         initAttribute(param1,param2);
         initInlay(param1);
         initSkill(param1,param2);
         initSuit(param1,param2);
      }
      
      public function clean() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _subBox2.removeAllChild();
         _subBox3.removeAllChild();
         _totalBox.removeAllChild();
         while(_contain2.numChildren)
         {
            _contain2.removeChildAt(0);
         }
         _loc1_ = 1;
         while(_loc1_ < 9)
         {
            if(this["_suitSkill" + _loc1_] && this["_suitSkill" + _loc1_].parent)
            {
               this["_suitSkill" + _loc1_].setData("");
               this["_suitSkill" + _loc1_].setFrame(1);
               this["_suitSkill" + _loc1_].parent.removeChild(this["_suitSkill" + _loc1_]);
            }
            if(this["_suit" + _loc1_].parent)
            {
               this["_suit" + _loc1_].parent.removeChild(this["_suit" + _loc1_]);
            }
            if(_refreshTitle.parent)
            {
               _refreshTitle.parent.removeChild(_refreshTitle);
            }
            if(_loc1_ < 5)
            {
               if(this["_inlayItem" + _loc1_].parent)
               {
                  this["_inlayItem" + _loc1_].parent.removeChild(this["_inlayItem" + _loc1_]);
               }
            }
            if(_loc1_ < 6)
            {
               if(this["_refreshItem" + _loc1_].parent)
               {
                  this["_refreshItem" + _loc1_].parent.removeChild(this["_refreshItem" + _loc1_]);
               }
            }
            if(this["_suitSkill" + _loc1_].parent)
            {
               this["_suitSkill" + _loc1_].parent.removeChild(this["_suitSkill" + _loc1_]);
            }
            _loc1_++;
         }
         if(_baseLine && _baseLine.parent)
         {
            _baseLine.parent.removeChild(_baseLine);
         }
         if(_gemLine && _gemLine.parent)
         {
            _gemLine.parent.removeChild(_gemLine);
         }
         if(_refreshLine && _refreshLine.parent)
         {
            _refreshLine.parent.removeChild(_refreshLine);
         }
         if(_suitLine && _suitLine.parent)
         {
            _suitLine.parent.removeChild(_suitLine);
         }
         if(_honerTxt01 && _honerTxt01.parent)
         {
            _honerTxt01.parent.removeChild(_honerTxt01);
         }
         if(_honerTxt02 && _honerTxt02.parent)
         {
            _honerTxt02.parent.removeChild(_honerTxt02);
         }
      }
      
      public function set spacing(param1:Number) : void
      {
         _totalBox.beginChanges();
         _totalBox.spacing = param1;
         _totalBox.commitChanges();
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         clean();
         b = false;
         _mouldGrade = param1.mouldGrade;
         initData(param1,TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId));
         _totalBox.beginChanges();
         if(param1.templateInfo.StrengthenMax > 0)
         {
            _contain2.addChild(_intensifyText);
         }
         if(FrameControllerManager.instance.fashionCodeController.model.isInBookList(param1.templateId))
         {
            _contain2.addChild(_isActivate);
         }
         if(_subBox1.numChildren > 0)
         {
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_baseLine);
         }
         if(_subBox2.numChildren > 0)
         {
            _totalBox.addChild(_subBox2);
            if(param1.templateInfo.MasterType != 3)
            {
               _totalBox.addChild(_attributeLine);
            }
         }
         if(_subBox3.numChildren > 0)
         {
            _totalBox.addChild(_subBox3);
         }
         if(!StringHelper.isNullOrEmpty(_describe.text))
         {
            _totalBox.addChild(_describe);
         }
         _totalBox.commitChanges();
      }
      
      private function getIndex(param1:GoodsTemplateInfo) : int
      {
         if(!param1)
         {
            return -1;
         }
         if(param1.MasterType != 1)
         {
            return -1;
         }
         if(param1.SonType == 112)
         {
            return 0;
         }
         if(param1.SonType == 110)
         {
            return 0;
         }
         if(param1.SonType == 111)
         {
            return 0;
         }
         if(param1.SonType == 109)
         {
            return 1;
         }
         return -1;
      }
      
      private function setFashionAtt(param1:GoodsInfo) : String
      {
         var _loc3_:SkillTempInfo = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = "";
         if(FrameControllerManager.instance.fashionCodeController.model.isFashion(param1))
         {
            if(GoodsCheck.isFashion(param1.templateInfo))
            {
               _loc3_ = fashionModel.getFashionObjectSkillTemplate(param1.templateInfo);
               _loc5_ = addMaxPropertyTxt(param1.templateInfo);
               if(_loc3_ == null)
               {
                  _loc2_ = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.noIdentity") + "(" + _loc5_ + ")";
               }
               else
               {
                  if(_loc3_.Grades == 5)
                  {
                     _loc5_ = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.identityTip2_max");
                  }
                  _loc4_ = _loc3_.TemplateName;
                  _loc2_ = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.identityTip2",_loc4_,_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      protected function addMaxPropertyTxt(param1:GoodsTemplateInfo) : String
      {
         var _loc3_:Dictionary = TempleteManager.instance.skillTemplateDic;
         for each(var _loc2_:SkillTempInfo in _loc3_)
         {
            if(_loc2_.MasterType == param1.SonType * 10 && _loc2_.SonType == param1.TransformId && _loc2_.Grades == 5)
            {
               return LanguageMgr.GetTranslation("fashion.FashionSwitchItem.identityTip2_Value",_loc2_.TemplateName);
            }
         }
         return "";
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_contain1);
         ObjectUtils.disposeAllChildren(_contain2);
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_fashionLevel)
         {
            _fashionLevel.dispose();
         }
         _fashionLevel = null;
         if(_intensifyText)
         {
            _intensifyText.dispose();
         }
         _intensifyText = null;
         if(_bindText)
         {
            _bindText.dispose();
         }
         _bindText = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_subBox1)
         {
            _subBox1.dispose();
         }
         _subBox1 = null;
         if(_contain1)
         {
            ObjectUtils.disposeObject(_contain1);
         }
         _contain1 = null;
         if(_contain1)
         {
            ObjectUtils.disposeObject(_contain1);
         }
         _contain1 = null;
         if(_vocation)
         {
            _vocation.dispose();
         }
         _vocation = null;
         if(_type)
         {
            _type.dispose();
         }
         _type = null;
         if(_grade)
         {
            _grade.dispose();
         }
         _grade = null;
         if(_subBox2)
         {
            _subBox2.dispose();
         }
         _subBox2 = null;
         if(_power)
         {
            _power.dispose();
         }
         _power = null;
         if(_agility)
         {
            _agility.dispose();
         }
         _agility = null;
         if(_ability)
         {
            _ability.dispose();
         }
         _ability = null;
         if(_physique)
         {
            _physique.dispose();
         }
         _physique = null;
         if(_captain)
         {
            _captain.dispose();
         }
         _captain = null;
         if(_attack)
         {
            _attack.dispose();
         }
         _attack = null;
         if(_magicAttack)
         {
            _magicAttack.dispose();
         }
         _magicAttack = null;
         if(_defence)
         {
            _defence.dispose();
         }
         _defence = null;
         if(_magicDefence)
         {
            _magicDefence.dispose();
         }
         _magicDefence = null;
         if(_parry)
         {
            _parry.dispose();
         }
         _parry = null;
         if(_live)
         {
            _live.dispose();
         }
         _live = null;
         if(_forceHit)
         {
            _forceHit.dispose();
         }
         _forceHit = null;
         if(_conat)
         {
            _conat.dispose();
         }
         _conat = null;
         if(_inlayItem1)
         {
            _inlayItem1.dispose();
         }
         _inlayItem1 = null;
         if(_inlayItem2)
         {
            _inlayItem2.dispose();
         }
         _inlayItem2 = null;
         if(_inlayItem3)
         {
            _inlayItem3.dispose();
         }
         _inlayItem3 = null;
         if(_inlayItem4)
         {
            _inlayItem4.dispose();
         }
         _inlayItem4 = null;
         if(_skill)
         {
            _skill.dispose();
         }
         _skill = null;
         if(_subBox3)
         {
            _subBox3.dispose();
         }
         _subBox3 = null;
         if(_suitTitle)
         {
            _suitTitle.dispose();
         }
         _suitTitle = null;
         if(_suit1)
         {
            _suit1.dispose();
         }
         _suit1 = null;
         if(_suit2)
         {
            _suit2.dispose();
         }
         _suit2 = null;
         if(_suit3)
         {
            _suit3.dispose();
         }
         _suit3 = null;
         if(_suit4)
         {
            _suit4.dispose();
         }
         _suit4 = null;
         if(_suit5)
         {
            _suit5.dispose();
         }
         _suit5 = null;
         if(_suit6)
         {
            _suit6.dispose();
         }
         _suit6 = null;
         if(_suit7)
         {
            _suit7.dispose();
         }
         _suit7 = null;
         if(_suit8)
         {
            _suit8.dispose();
         }
         _suit8 = null;
         if(_suitSkill1)
         {
            _suitSkill1.dispose();
         }
         _suitSkill1 = null;
         if(_suitSkill2)
         {
            _suitSkill2.dispose();
         }
         _suitSkill2 = null;
         if(_suitSkill3)
         {
            _suitSkill3.dispose();
         }
         _suitSkill3 = null;
         if(_suitSkill4)
         {
            _suitSkill4.dispose();
         }
         _suitSkill4 = null;
         if(_suitSkill5)
         {
            _suitSkill5.dispose();
         }
         _suitSkill5 = null;
         if(_suitSkill6)
         {
            _suitSkill6.dispose();
         }
         _suitSkill6 = null;
         if(_suitSkill7)
         {
            _suitSkill7.dispose();
         }
         _suitSkill7 = null;
         if(_suitSkill8)
         {
            _suitSkill8.dispose();
         }
         _suitSkill8 = null;
         if(_equipIcon)
         {
            _equipIcon.dispose();
         }
         _equipIcon = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_addImg)
         {
            ObjectUtils.disposeObject(_addImg);
         }
         _addImg = null;
         if(_strengNumSprite)
         {
            ObjectUtils.disposeObject(_strengNumSprite);
         }
         _strengNumSprite = null;
         if(_strengImg)
         {
            ObjectUtils.disposeObject(_strengImg);
         }
         _strengImg = null;
         if(_gemSprite)
         {
            ObjectUtils.disposeObject(_gemSprite);
         }
         _gemSprite = null;
         if(_gemTxt)
         {
            ObjectUtils.disposeObject(_gemTxt);
         }
         _gemTxt = null;
         if(_refreshSprite)
         {
            ObjectUtils.disposeObject(_refreshSprite);
         }
         _refreshSprite = null;
         if(_refreshTitle)
         {
            ObjectUtils.disposeObject(_refreshTitle);
         }
         _refreshTitle = null;
         if(_simpleSuitSkillItem)
         {
            ObjectUtils.disposeObject(_simpleSuitSkillItem);
         }
         _simpleSuitSkillItem = null;
         if(_gemVbox)
         {
            ObjectUtils.disposeObject(_gemVbox);
         }
         _gemVbox = null;
         if(_refreshVBox)
         {
            ObjectUtils.disposeObject(_refreshVBox);
         }
         _refreshVBox = null;
         if(_refreshItem1)
         {
            ObjectUtils.disposeObject(_refreshItem1);
         }
         _refreshItem1 = null;
         if(_refreshItem2)
         {
            ObjectUtils.disposeObject(_refreshItem2);
         }
         _refreshItem2 = null;
         if(_refreshItem3)
         {
            ObjectUtils.disposeObject(_refreshItem3);
         }
         _refreshItem3 = null;
         if(_refreshItem4)
         {
            ObjectUtils.disposeObject(_refreshItem4);
         }
         _refreshItem4 = null;
         if(_refreshItem5)
         {
            ObjectUtils.disposeObject(_refreshItem5);
         }
         _refreshItem5 = null;
         if(_castSelected)
         {
            ObjectUtils.disposeObject(_castSelected);
         }
         _castSelected = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

