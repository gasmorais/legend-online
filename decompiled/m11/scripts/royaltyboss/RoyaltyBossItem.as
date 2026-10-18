package royaltyboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.royaltyboss.RoyaltyBossModel;
   import yishi.datas.templates.RoyaltyBossTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class RoyaltyBossItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _txtBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _data:RoyaltyBossTempInfo;
      
      public function RoyaltyBossItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossItem.bg");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossItem.txtBg");
         _icon = ComponentFactory.Instance.creatCustomObject("royaltyBossItem.icon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossItem.nameTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossItem.levelTxt");
         addChild(_bg);
         addChild(_txtBg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_levelTxt);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_index > 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("royaltyBossItem.unlock.tip"));
         }
         else if(_index == 1)
         {
            FrameControllerManager.instance.openControllerByInfo("royaltyboss",2);
         }
      }
      
      public function set data(param1:RoyaltyBossTempInfo) : void
      {
         _data = param1;
         _icon.icon = IconFactory.getCommonIconPath(_data.HeroIcon);
         _nameTxt.text = _data.getBossName();
         _levelTxt.text = LanguageMgr.GetTranslation("royaltyBossItem.levelTxt.text",_data.Level);
         if(_index == 1)
         {
            this.buttonMode = true;
         }
         else if(_index > 1)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function get model() : RoyaltyBossModel
      {
         return RoyaltyBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

