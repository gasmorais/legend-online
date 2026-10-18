package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.CatHouseTemplateInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class CatToyTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _nameTxt:FilterFrameText;
      
      private var _matureTimeTxt:FilterFrameText;
      
      private var _outputTxt:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      public function CatToyTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 237;
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _matureTimeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _outputTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _nameTxt.x = 76;
         _nameTxt.y = 15;
         _nameTxt.width = 145;
         _totalBox.x = 10;
         _totalBox.spacing = 4;
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         addChild(_nameTxt);
         addChild(_totalBox);
         _totalBox.y = 55;
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:CatHouseTemplateInfo = null;
         var _loc1_:String = null;
         if(tipData)
         {
            clean();
            _loc2_ = tipData as CatHouseTemplateInfo;
            _itemIcon.icon = IconFactory.getCatHouseIconPath(_loc2_.Icon);
            _profileImg.setFrame(_loc2_.Profile);
            if(_loc2_)
            {
               _totalBox.addChild(_matureTimeTxt);
               _totalBox.addChild(_outputTxt);
               _loc1_ = "";
               _nameTxt.text = _loc2_.TemplateName;
               _nameTxt.setFrame(_loc2_.Profile);
               if(int(_loc2_.GrowingMinute / 60) <= 0)
               {
                  _loc1_ = LanguageMgr.GetTranslation("public.needMinutes",_loc2_.GrowingMinute % 60);
               }
               else if(_loc2_.GrowingMinute % 60 == 0)
               {
                  _loc1_ = int(_loc2_.GrowingMinute / 60) + LanguageMgr.GetTranslation("public.time.hour");
               }
               else
               {
                  _loc1_ = LanguageMgr.GetTranslation("public.needHM",int(_loc2_.GrowingMinute / 60),_loc2_.GrowingMinute % 60);
               }
               _matureTimeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.matureTime",_loc1_);
               _loc1_ = _loc2_.OutGold + LanguageMgr.GetTranslation("mainBar.view.ResourceView.gold");
               _outputTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.output",_loc1_);
            }
            _totalBox.refreshChildPos();
            _bg.height = _totalBox.y + _totalBox.height + 10;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _yellowBg.width = _bg.width;
            _purpleBg.width = _bg.width;
            _blueBg.width = _bg.width;
            _greenBg.width = _bg.width;
            _whiteBg.width = _bg.width;
            _yellowBg.y = _bg.y - 3;
            _purpleBg.y = _bg.y - 3;
            _blueBg.y = _bg.y - 3;
            _greenBg.y = _bg.y - 3;
            _whiteBg.y = _bg.y - 3;
            showProfileBg(_loc2_.Profile);
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
         }
      }
      
      private function clean() : void
      {
         while(_totalBox.numChildren > 0)
         {
            _totalBox.removeChildAt(_totalBox.numChildren - 1);
         }
      }
      
      override public function dispose() : void
      {
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
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_matureTimeTxt)
         {
            _matureTimeTxt.dispose();
         }
         _matureTimeTxt = null;
         if(_outputTxt)
         {
            _outputTxt.dispose();
         }
         _outputTxt = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

