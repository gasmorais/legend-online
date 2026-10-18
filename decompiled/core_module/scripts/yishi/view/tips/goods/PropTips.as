package yishi.view.tips.goods
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class PropTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _usedTimes:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      private var _send:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _blackKingBg:Scale9CornerImage;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      private var _splitLine03:Bitmap;
      
      public function PropTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 361;
         _container = new Sprite();
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTypeTxt");
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText1");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         _usedTimes = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         _price = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText_2");
         _send = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _grade.x = 240;
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine03 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine01.width = 300;
         _splitLine02.width = 300;
         _splitLine02.width = 300;
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         _describe.width = 327;
         _usedTimes.width = 327;
         addChild(_title);
         _title.width = 250;
         _title.x = 71;
         _title.height = 40;
         _title.wordWrap = true;
         _title.y = 15;
         _type.x = 0;
         _type.y = 0;
         _totalBox.x = 10;
         _totalBox.y = 58;
         _totalBox.spacing = 4;
         _grade.x = 115;
         addChild(_totalBox);
         _price.x = 5;
         _bindText.x = 0;
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc1_:String = null;
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc2_:int = 0;
         if(tipData)
         {
            clean();
            _loc5_ = tipData as GoodsInfo;
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc5_.templateInfo.TemplateId);
            _profileImg.setFrame(_loc5_.templateInfo.Profile);
            _title.setFrame(_loc5_.templateInfo.Profile);
            _title.text = _loc5_.templateInfo.TemplateName;
            _title.height = 42;
            _title.wordWrap = true;
            _type.text = getGoodsTypeName(_loc5_.templateInfo);
            if(_type && _type.parent)
            {
               _type.parent.removeChild(_type);
            }
            if(_type.text != "")
            {
               _totalBox.addChild(_type);
            }
            if(_loc5_.isBinds)
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               _bindText.setFrame(1);
            }
            else
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               _bindText.setFrame(2);
            }
            _describe.htmlText = _loc5_.templateInfo.Description;
            _describe.height = _describe.textHeight + 4;
            if(_describe.height < 22)
            {
               _describe.height = _describe.textHeight;
            }
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",_loc5_.templateInfo.SellGold * (1 + _loc5_.strengthenGrade * 2));
            _price.text = _loc5_.templateInfo.SellGold == 0 ? "" : _loc1_;
            if(_loc5_.templateInfo.NeedGrades > 1)
            {
               _grade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.grade02",_loc5_.templateInfo.NeedGrades);
               if(!GoodsCheck.isGradeFix(ArmyManager.instance.thane,_loc5_.templateInfo,false))
               {
                  _grade.textColor = 16711680;
               }
               _container.addChild(_grade);
               _grade.visible = true;
            }
            else
            {
               _grade.visible = false;
            }
            _totalBox.addChild(_container);
            if(_loc5_.id != 0)
            {
               _container.addChild(_bindText);
               _bindText.visible = true;
               _totalBox.addChild(_splitLine01);
               _totalBox.addChild(_describe);
               _totalBox.addChild(_splitLine02);
               if(_loc5_.templateInfo.SonType == 609)
               {
                  _totalBox.addChild(_usedTimes);
                  _totalBox.addChild(_splitLine03);
                  _loc3_ = _loc5_.isTodayUsed ? LanguageMgr.GetTranslation("TimesPropTip01") : LanguageMgr.GetTranslation("TimesPropTip02");
                  _usedTimes.htmlText = _loc3_ + LanguageMgr.GetTranslation("TimesPropTip03",_loc5_.templateInfo.Property2 - _loc5_.usedTimes);
                  _usedTimes.height = _usedTimes.textHeight + 4;
                  if(_usedTimes.height < 22)
                  {
                     _usedTimes.height = _usedTimes.textHeight;
                  }
               }
               if(_loc5_.validDate > 0)
               {
                  _totalBox.addChild(_timeText);
               }
               if(_loc5_.leftTime == -1)
               {
                  _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc5_.leftTime < 0)
               {
                  _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc4_ = DateFormatter.getFullDateString(_loc5_.leftTime);
               }
               _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc4_;
               if(_loc5_.templateId != 208002 && _loc5_.templateId != 208003)
               {
                  _send.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
                  _totalBox.addChild(_send);
               }
               if(_loc5_.templateInfo.SellGold > 0)
               {
                  _totalBox.addChild(_price);
               }
            }
            else
            {
               _bindText.visible = false;
               _totalBox.addChild(_describe);
               if(_loc5_.validDate > 0)
               {
                  _totalBox.addChild(_timeText);
               }
               if(_loc5_.leftTime == -1)
               {
                  _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc5_.leftTime < 0)
               {
                  _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc4_ = DateFormatter.getFullDateString(_loc5_.leftTime);
               }
               _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc4_;
               _totalBox.height = _describe.textHeight;
               _totalBox.draw();
            }
            _bg.height = _totalBox.y + _totalBox.height + 10;
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
            showProfileBg(_loc5_.templateInfo.Profile);
            _loc2_ = Math.max(_bg.width,_totalBox.width + 20,_title.x + _title.width + 20);
            _bg.width = _loc2_;
         }
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         while(_totalBox.numChildren > 0)
         {
            _loc1_ = _totalBox.getChildAt(0);
            _totalBox.removeChild(_loc1_);
         }
      }
      
      private function getGoodsTypeName(param1:GoodsTemplateInfo) : String
      {
         switch(param1.SonType - 210)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.SONTYPE_TASK");
            case 2:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.COMPOSE_MATERIAL");
            default:
               return "";
         }
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
         ObjectUtils.disposeAllChildren(_container);
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
         if(_timeText)
         {
            _timeText.dispose();
         }
         _timeText = null;
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
         if(_type)
         {
            _type.dispose();
         }
         _type = null;
         if(_bindText)
         {
            _bindText.dispose();
         }
         _bindText = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
         if(_grade)
         {
            _grade.dispose();
         }
         _grade = null;
         if(_send)
         {
            _send.dispose();
         }
         _send = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

