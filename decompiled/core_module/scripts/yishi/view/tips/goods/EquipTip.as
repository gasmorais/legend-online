package yishi.view.tips.goods
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   import yishi.view.tips.BaseTip;
   
   public class EquipTip extends BaseTip
   {
      
      public static const EQUIPED:int = 1;
      
      public static var isOpenFirstPayFrame:Boolean = false;
      
      protected var _totalBox:VBox;
      
      protected var _equiped:FilterFrameText;
      
      protected var _equipTipsContent:EquipTipsContent;
      
      private var _time:FilterFrameText;
      
      private var _send:FilterFrameText;
      
      protected var _price:FilterFrameText;
      
      protected var _gradeCount:FilterFrameText;
      
      protected var _fashionIdentityTipTxt:FilterFrameText;
      
      protected var _fashionProfileTxt:FilterFrameText;
      
      protected var _blackKingBg:Scale9CornerImage;
      
      protected var _redBg:Scale9CornerImage;
      
      protected var _yellowBg:Scale9CornerImage;
      
      protected var _purpleBg:Scale9CornerImage;
      
      protected var _blueBg:Scale9CornerImage;
      
      protected var _greenBg:Scale9CornerImage;
      
      protected var _whiteBg:Scale9CornerImage;
      
      private var _splitLine:Bitmap;
      
      protected var _hbox:HBox;
      
      private const TEMP_TYPE:int = 40;
      
      public function EquipTip()
      {
         super();
      }
      
      public function set type(param1:int) : void
      {
         if(param1 == 1)
         {
            _equiped.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.equiped");
            addChild(_equiped);
            _bg.y = -25;
            _redBg.y = -18;
            _yellowBg.y = -18;
            _purpleBg.y = -18;
            _blueBg.y = -18;
            _greenBg.y = -18;
            _whiteBg.y = -18;
            _blackKingBg.y = -18;
         }
      }
      
      public function set showEquipBg(param1:Boolean) : void
      {
         if(param1)
         {
            _bg.y = -25;
            _redBg.y = -18;
            _yellowBg.y = -18;
            _purpleBg.y = -18;
            _blueBg.y = -18;
            _greenBg.y = -18;
            _whiteBg.y = -18;
            _blackKingBg.y = -18;
         }
         else
         {
            _bg.y = 0;
            _redBg.y = 9;
            _yellowBg.y = 9;
            _purpleBg.y = 9;
            _blueBg.y = 9;
            _greenBg.y = 9;
            _whiteBg.y = 9;
            _blackKingBg.y = 9;
         }
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 380;
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _equiped = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsEquiped_2");
         _equipTipsContent = new EquipTipsContent();
         _gradeCount = ComponentFactory.Instance.creatComponentByStylename("tips.GoodgradeCountText");
         _price = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _time = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         _send = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _fashionIdentityTipTxt = ComponentFactory.Instance.creatComponentByStylename("tips.fashionIdentityTipTxt");
         _fashionProfileTxt = ComponentFactory.Instance.creatComponentByStylename("tips.fashionProfileTxt");
         _hbox = new HBox();
         _hbox.spacing = 1;
         addChild(_totalBox);
         _totalBox.x = 10;
         _totalBox.y = 10;
         _totalBox.spacing = 8;
      }
      
      override protected function updateTransform() : void
      {
         var _loc11_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc8_:SkillTempInfo = null;
         var _loc10_:Array = null;
         var _loc5_:String = null;
         var _loc7_:ThaneInfo = null;
         var _loc4_:Number = NaN;
         var _loc9_:String = null;
         if(tipData)
         {
            _totalBox.removeAllChild();
            _loc11_ = tipData as GoodsInfo;
            _loc3_ = _loc11_.templateInfo;
            _bg.visible = false;
            hidenBg(_loc3_.Profile);
            _equipTipsContent.data = _loc11_;
            _totalBox.beginChanges();
            _totalBox.addChild(_equipTipsContent);
            _loc6_ = _loc11_.getEquipBaseScore();
            _loc1_ = _loc11_.getEquipAdditionScore();
            if(_loc1_ > 0)
            {
               _loc2_ = _loc6_ + " (+" + _loc1_ + ")";
            }
            else
            {
               _loc2_ = _loc6_ + "";
            }
            _gradeCount.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ChatEquipTips.gradeCount",_loc2_);
            if(FrameControllerManager.instance.fashionCodeController.model.isFashion(_loc11_))
            {
               if(_gradeCount && _gradeCount.parent)
               {
                  _gradeCount.parent.removeChild(_gradeCount);
               }
               _loc8_ = TempleteManager.instance.getSkillTemplateInfoById(_loc11_.appraisal_skill);
               if(VersionSwitch.FASHION_APPRAISAL)
               {
                  if(_hbox && _loc8_)
                  {
                     _hbox.removeAllChild();
                     _totalBox.addChild(_hbox);
                     addFashionStar(_loc8_.Grades);
                  }
               }
               _loc10_ = [" ","S","A","B","C","D"];
               if(_loc3_.TransformId > 0)
               {
                  _loc5_ = StringHelper.format("<font color=\'{0}\'>{1}</font>",GoodsSonType.getColorByProfile(6 - _loc3_.TransformId),LanguageMgr.GetTranslation("public.level") + " " + _loc10_[_loc3_.TransformId]);
               }
               else
               {
                  _loc5_ = "";
               }
               if(_loc3_.Property4 == 0)
               {
                  _fashionProfileTxt.setFrame(3);
                  _fashionProfileTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.specialFashion") + " " + _loc5_;
                  _fashionProfileTxt.x = 0;
                  _totalBox.addChild(_fashionProfileTxt);
                  if(_loc11_.id != 0)
                  {
                     _totalBox.addChild(_splitLine);
                  }
                  else if(_splitLine.parent)
                  {
                     _splitLine.parent.removeChild(_splitLine);
                  }
               }
               else if(_loc3_.Property4 == 2)
               {
                  _fashionProfileTxt.setFrame(2);
                  _fashionProfileTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.activeFashion") + " " + _loc5_;
                  _fashionProfileTxt.x = 0;
                  _totalBox.addChild(_fashionProfileTxt);
                  if(_loc11_.id != 0)
                  {
                     _totalBox.addChild(_splitLine);
                  }
                  else if(_splitLine.parent)
                  {
                     _splitLine.parent.removeChild(_splitLine);
                  }
               }
               else
               {
                  _fashionProfileTxt.setFrame(1);
                  _fashionProfileTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.normalFashion") + " " + _loc5_;
                  _fashionProfileTxt.x = 0;
                  _totalBox.addChild(_fashionProfileTxt);
                  if(_loc11_.id != 0)
                  {
                     _totalBox.addChild(_splitLine);
                  }
                  else if(_splitLine.parent)
                  {
                     _splitLine.parent.removeChild(_splitLine);
                  }
               }
            }
            if(_loc11_.templateInfo.MasterType == 5 || _loc11_.templateInfo.MasterType != 1)
            {
               _price.text = _loc3_.SellGold == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",GoodsCheck.getPetEquipSellGold(_loc11_));
            }
            else if(_loc11_.templateInfo.MasterType == 6)
            {
               _price.text = _loc3_.SellGold == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",GoodsCheck.getChildSellGold(_loc11_));
            }
            else
            {
               _price.text = _loc3_.SellGold == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",GoodsCheck.getSellGold(_loc11_));
            }
            _loc7_ = ArmyManager.instance.thane;
            _loc4_ = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            _loc9_ = "";
            if(isCanUpdateMedal(_loc11_) && _loc11_.userId == _loc7_.userId)
            {
               _totalBox.addChild(_time);
            }
            else
            {
               if(_loc11_.validDate > 0)
               {
                  _totalBox.addChild(_time);
               }
               _time.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + DateFormatter.getFullDateString(_loc11_.validDate * 60);
            }
            if(_loc11_.id != 0)
            {
               if(isCanUpdateMedal(_loc11_) && _loc11_.userId == _loc7_.userId)
               {
                  if(_loc7_.medalInvalidTime > 0)
                  {
                     _loc9_ = DateFormatter.getFullDateString(_loc7_.medalInvalidTime - _loc4_);
                  }
                  else
                  {
                     _loc9_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
                  }
               }
               else if(_loc11_.leftTime == -1)
               {
                  _loc9_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc11_.leftTime < 0)
               {
                  _loc9_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc9_ = DateFormatter.getFullDateString(_loc11_.leftTime);
               }
               _time.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc9_;
               _send.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
               _totalBox.addChild(_send);
               if(_loc3_.SellGold > 0)
               {
                  _totalBox.addChild(_price);
               }
            }
            else if(isCanUpdateMedal(_loc11_) && _loc11_.userId == _loc7_.userId)
            {
               if(_loc7_.medalInvalidTime > 0)
               {
                  _loc9_ = DateFormatter.getFullDateString(_loc7_.medalInvalidTime - _loc4_);
               }
               else
               {
                  _loc9_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               _time.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc9_;
            }
            _totalBox.commitChanges();
            _bg.height = int(-_bg.y + _totalBox.y + _totalBox.height + 10);
            _bg.width = 380;
            _redBg.height = _bg.height;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _blackKingBg.height = _bg.height;
            if(!_equipTipsContent.b)
            {
               _blackKingBg.width = _bg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = 380;
            }
            else
            {
               _blackKingBg.width = _bg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = 380;
            }
         }
      }
      
      protected function addFashionStar(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc2_:Bitmap = null;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            if(_loc4_ < param1)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.fashion.StarLevelLightImg");
               _hbox.addChild(_loc3_);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.fashion.StarLeveldarkImg");
               _hbox.addChild(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function isCanUpdateMedal(param1:GoodsInfo) : Boolean
      {
         var _loc2_:Array = null;
         if(param1 && param1.templateInfo.SonType == 301)
         {
            _loc2_ = TempleteManager.instance.getTemplatesByType(40);
            for each(var _loc3_:UpgradeTemplateInfo in _loc2_)
            {
               if(_loc3_.TemplateId == param1.templateId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function setHight(param1:Boolean) : void
      {
         if(param1)
         {
            _bg.height = int(-_bg.y + _totalBox.y + _totalBox.height + 35);
            _bg.width = 380;
            _redBg.height = _bg.height - 25;
            _yellowBg.height = _bg.height - 25;
            _purpleBg.height = _bg.height - 25;
            _blueBg.height = _bg.height - 25;
            _greenBg.height = _bg.height - 25;
            _whiteBg.height = _bg.height - 25;
            _blackKingBg.height = _bg.height - 25;
         }
         else
         {
            _bg.height = int(-_bg.y + _totalBox.y + _totalBox.height + 10);
            _bg.width = 380;
            _redBg.height = _bg.height;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _blackKingBg.height = _bg.height;
         }
      }
      
      override public function dispose() : void
      {
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_equiped)
         {
            _equiped.dispose();
         }
         _equiped = null;
         if(_equipTipsContent)
         {
            _equipTipsContent.dispose();
         }
         _equipTipsContent = null;
         if(_time)
         {
            _time.dispose();
         }
         _time = null;
         if(_send)
         {
            _send.dispose();
         }
         _send = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
         if(_gradeCount)
         {
            _gradeCount.dispose();
         }
         _gradeCount = null;
         ObjectUtils.disposeObject(_fashionIdentityTipTxt);
         _fashionIdentityTipTxt = null;
         ObjectUtils.disposeObject(_redBg);
         _redBg = null;
         ObjectUtils.disposeObject(_yellowBg);
         _yellowBg = null;
         ObjectUtils.disposeObject(_purpleBg);
         _purpleBg = null;
         ObjectUtils.disposeObject(_blueBg);
         _blueBg = null;
         ObjectUtils.disposeObject(_greenBg);
         _greenBg = null;
         ObjectUtils.disposeObject(_whiteBg);
         _whiteBg = null;
         ObjectUtils.disposeObject(_blackKingBg);
         _blackKingBg = null;
         ObjectUtils.disposeObject(_fashionProfileTxt);
         _fashionProfileTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(_splitLine)
         {
            ObjectUtils.disposeObject(_splitLine);
         }
         _splitLine = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function hidenBg(param1:int) : void
      {
         _redBg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
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
         }
      }
      
      public function changeBg(param1:Boolean) : void
      {
         if(param1)
         {
            _redBg.width = 380;
            _yellowBg.width = 380;
            _purpleBg.width = 380;
            _blueBg.width = 380;
            _greenBg.width = 380;
            _whiteBg.width = 380;
         }
         else
         {
            _redBg.width = 380;
            _yellowBg.width = 380;
            _purpleBg.width = 380;
            _blueBg.width = 380;
            _greenBg.width = 380;
            _whiteBg.width = 380;
         }
      }
      
      protected function clean() : void
      {
      }
   }
}

