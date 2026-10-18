package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.RuneGemTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.SkillTipItem;
   
   public class RuneStoneTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _blackKingBg:Scale9CornerImage;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _iconBack:Bitmap;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _splitLine01:Bitmap;
      
      private var _totalBox:VBox;
      
      private var _proItem:SkillTipItem;
      
      private var _maxTxt:FilterFrameText;
      
      public function RuneStoneTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 262;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.core2.boxBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _maxTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _splitLine01.width = 215;
         _proItem = new SkillTipItem();
         _totalBox = new VBox();
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_iconBack);
         _iconBack.x = 8;
         _iconBack.y = -9;
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         addChild(_title);
         _title.width = 195;
         _title.x = 68;
         addChild(_totalBox);
         _totalBox.x = 10;
         _totalBox.y = 58;
         _totalBox.spacing = 20;
         _maxTxt.x = 85;
      }
      
      private function getListByType(param1:int) : Array
      {
         var _loc6_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc5_:Array = TempleteManager.instance.getTemplatesByType(160);
         var _loc3_:int = int(_loc5_.length);
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc5_[_loc4_];
            if(_loc6_.TemplateId == param1)
            {
               _loc2_.push(_loc6_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc1_:String = null;
         var _loc5_:RuneGemTempInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         if(tipData)
         {
            _loc6_ = tipData as GoodsInfo;
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc6_.templateInfo.TemplateId);
            _profileImg.setFrame(_loc6_.templateInfo.Profile);
            _title.setFrame(_loc6_.templateInfo.Profile);
            _title.text = _loc6_.templateInfo.TemplateName + "  " + LanguageMgr.GetTranslation("public.level2",_loc6_.strengthenGrade);
            _title.height = 42;
            _title.wordWrap = true;
            _loc3_ = _data.templateInfo;
            _loc1_ = "";
            if(_loc6_.strengthenGrade > 0)
            {
               _loc5_ = TempleteManager.instance.runeGemInfoCate.getInfo(_loc3_.SonType,_loc3_.Property1,_loc6_.strengthenGrade);
               _loc1_ = getPropertys(_loc5_);
            }
            else
            {
               _loc1_ = getPropertys(_loc3_);
            }
            _loc2_ = getListByType(_loc3_.SonType);
            _loc4_ = int(_loc2_[_loc2_.length - 1] ? _loc2_[_loc2_.length - 1].Grades : 0);
            _maxTxt.text = LanguageMgr.GetTranslation("runetip.max.tip",_loc4_);
            _proItem.setSkillTxt(_loc1_);
            _totalBox.removeAllChild();
            _totalBox.beginChanges();
            _totalBox.addChild(_splitLine01);
            _totalBox.addChild(_proItem);
            _totalBox.addChild(_maxTxt);
            _totalBox.commitChanges();
            _bg.height = _totalBox.y + _totalBox.height + 20;
            _blackKingBg.height = _bg.height;
            _redBg.height = _bg.height;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _blackKingBg.width = _bg.width;
            _redBg.width = _bg.width;
            _yellowBg.width = _bg.width;
            _purpleBg.width = _bg.width;
            _blueBg.width = _bg.width;
            _greenBg.width = _bg.width;
            _whiteBg.width = _bg.width;
            _blackKingBg.y = _bg.y - 3;
            _redBg.y = _bg.y - 3;
            _yellowBg.y = _bg.y - 3;
            _purpleBg.y = _bg.y - 3;
            _blueBg.y = _bg.y - 3;
            _greenBg.y = _bg.y - 3;
            _whiteBg.y = _bg.y - 3;
            showProfileBg(_loc6_.templateInfo.Profile);
         }
      }
      
      private function getPropertys(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return "";
         }
         var _loc6_:Array = ["Power","Agility","Intellect","Physique","Captain"];
         var _loc5_:int = int(_loc6_.length);
         var _loc3_:String = "";
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc6_[_loc7_];
            if(param1[_loc2_] > 0)
            {
               _loc4_ = int(param1[_loc2_]);
               _loc3_ = LanguageMgr.GetTranslation("army.stone." + _loc2_,_loc4_);
               break;
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         _redBg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         _blackKingBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
               break;
            case 6:
               _blackKingBg.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         if(_redBg)
         {
            ObjectUtils.disposeObject(_redBg);
         }
         _redBg = null;
         if(_yellowBg)
         {
            ObjectUtils.disposeObject(_yellowBg);
         }
         _yellowBg = null;
         if(_purpleBg)
         {
            ObjectUtils.disposeObject(_purpleBg);
         }
         _purpleBg = null;
         if(_blueBg)
         {
            ObjectUtils.disposeObject(_blueBg);
         }
         _blueBg = null;
         if(_greenBg)
         {
            ObjectUtils.disposeObject(_greenBg);
         }
         _greenBg = null;
         if(_whiteBg)
         {
            ObjectUtils.disposeObject(_whiteBg);
         }
         _whiteBg = null;
         if(_blackKingBg)
         {
            ObjectUtils.disposeObject(_blackKingBg);
         }
         _blackKingBg = null;
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         ObjectUtils.disposeObject(_maxTxt);
         _maxTxt = null;
         ObjectUtils.disposeObject(_proItem);
         _proItem = null;
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         super.dispose();
      }
   }
}

