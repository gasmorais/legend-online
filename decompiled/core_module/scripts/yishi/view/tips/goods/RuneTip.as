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
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class RuneTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _title:FilterFrameText;
      
      private var _needJob:FilterFrameText;
      
      private var _needGrade:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _send:FilterFrameText;
      
      private var _container1:Sprite;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      public function RuneTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 302;
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText2");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         _price = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _needJob = ComponentFactory.Instance.creatComponentByStylename("tips.GoodJobText");
         _needGrade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _send = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine01.scaleX = 0.7;
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02.scaleX = 0.7;
         _totalBox.y = 36;
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         addChild(_title);
         addChild(_type);
         addChild(_totalBox);
         _totalBox.spacing = 4;
         _title.x = 80;
         _title.y = 12;
         _title.width = 210;
         _type.y = 36;
         _type.x = 85;
         _totalBox.x = 10;
         _needJob.x = 0;
         _needGrade.x = 100;
         _price.x = 0;
         _totalBox.y = 56;
         _bindText.x = 0;
         _describe.width = 280;
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(tipData)
         {
            clean();
            _loc3_ = tipData as GoodsInfo;
            _title.setFrame(_loc3_.templateInfo.Profile);
            _title.text = _loc3_.templateInfo.TemplateName;
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc3_.templateInfo.TemplateId);
            _profileImg.setFrame(_loc3_.templateInfo.Profile);
            if(_loc3_.isBinds)
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               _bindText.setFrame(1);
            }
            else
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               _bindText.setFrame(2);
            }
            _describe.text = _loc3_.templateInfo.Description;
            _describe.height = _describe.textHeight + 5;
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",_loc3_.templateInfo.SellGold * (1 + _loc3_.strengthenGrade * 2));
            _price.text = _loc3_.templateInfo.SellGold == 0 ? "" : _loc1_;
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.vocation.text") + _loc3_.templateInfo.jobName;
            _needJob.text = _loc1_;
            if(!GoodsCheck.isJobFix(ArmyManager.instance.thane,_loc3_.templateInfo,false))
            {
               _needJob.textColor = 16711680;
            }
            if(!StringHelper.isNullOrEmpty(_loc3_.templateInfo.jobName))
            {
               _totalBox.addChild(_needJob);
            }
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.grade02",_loc3_.templateInfo.NeedGrades);
            _needGrade.text = _loc1_;
            if(!GoodsCheck.isGradeFix(ArmyManager.instance.thane,_loc3_.templateInfo,false))
            {
               _needGrade.textColor = 16711680;
            }
            _container1 = new Sprite();
            _container1.addChild(_needGrade);
            _totalBox.addChild(_container1);
            if(_loc3_.id != 0)
            {
               _container1.addChild(_bindText);
               _bindText.visible = true;
               _totalBox.addChild(_splitLine01);
               _totalBox.addChild(_describe);
               _totalBox.addChild(_splitLine02);
               if(_loc3_.validDate > 0)
               {
                  _totalBox.addChild(_timeText);
               }
               if(_loc3_.leftTime == -1)
               {
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc3_.leftTime < 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc2_ = DateFormatter.getFullDateString(_loc3_.leftTime);
               }
               _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc2_;
               _send.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
               _totalBox.addChild(_send);
               _totalBox.addChild(_price);
            }
            else
            {
               _bindText.visible = false;
               _totalBox.addChild(_splitLine01);
               _totalBox.addChild(_describe);
               _totalBox.addChild(_splitLine02);
               if(_loc3_.validDate > 0)
               {
                  _totalBox.addChild(_timeText);
               }
               if(_loc3_.leftTime == -1)
               {
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc3_.leftTime < 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc2_ = DateFormatter.getFullDateString(_loc3_.leftTime);
               }
               _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc2_;
               _totalBox.height = _describe.textHeight;
               _totalBox.draw();
            }
            _bg.height = _totalBox.y + _totalBox.height + 10;
            _yellowBg.height = _bg.height;
            _yellowBg.width = _bg.width;
            _purpleBg.height = _bg.height;
            _purpleBg.width = _bg.width;
            _blueBg.height = _bg.height;
            _blueBg.width = _bg.width;
            _greenBg.height = _bg.height;
            _greenBg.width = _bg.width;
            _whiteBg.height = _bg.height;
            _whiteBg.width = _bg.width;
            showProfileBg(_loc3_.templateInfo.Profile);
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               _whiteBg.y = -3;
               break;
            case 1:
               _greenBg.visible = true;
               _greenBg.y = -3;
               break;
            case 2:
               _blueBg.visible = true;
               _blueBg.y = -3;
               break;
            case 3:
               _purpleBg.visible = true;
               _purpleBg.y = -3;
               break;
            case 4:
               _yellowBg.visible = true;
               _yellowBg.y = -3;
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
         return LanguageMgr.GetTranslation("yishi.view.tips.goods.RuneTip.GoodsTypeName");
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_container1);
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
         if(_splitLine01)
         {
            ObjectUtils.disposeObject(_splitLine01);
         }
         _splitLine01 = null;
         if(_splitLine02)
         {
            ObjectUtils.disposeObject(_splitLine02);
         }
         _splitLine02 = null;
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
         if(_needJob)
         {
            _needJob.dispose();
         }
         _needJob = null;
         if(_needGrade)
         {
            _needGrade.dispose();
         }
         _needGrade = null;
         if(_type)
         {
            _type.dispose();
         }
         _type = null;
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
         if(_bindText)
         {
            _bindText.dispose();
         }
         _bindText = null;
         if(_send)
         {
            _send.dispose();
         }
         _send = null;
         if(_container1)
         {
            ObjectUtils.disposeObject(_container1);
         }
         _container1 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

