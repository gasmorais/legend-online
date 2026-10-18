package vip
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.keyboard.KeyBoardRegister;
   
   public class VIPFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _vipBtn:SelectedIconButton;
      
      private var _shopBtn:SelectedIconButton;
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _vipView:VIPView;
      
      private var _shopView:VIPShopView;
      
      public function VIPFrame()
      {
         super();
         initView();
         initEvent();
         _btnGroup.selectIndex = 0;
         __btnGroupSelectedHandler(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,593,625);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("vip.view.VIPFrame.titleText");
         _vipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VIPFrame.vipBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VIPFrame.ShopBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("vip.VIPFrame.hbox");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_vipBtn);
         if(VersionSwitch.VIPSHOP)
         {
            _btnGroup.addSelectItem(_shopBtn);
         }
         _hbox.addChild(_vipBtn);
         if(VersionSwitch.VIPSHOP)
         {
            _hbox.addChild(_shopBtn);
         }
         addToContent(_hbox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnGroup.addEventListener("change",__btnGroupSelectedHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __btnGroupSelectedHandler(param1:Event) : void
      {
         var _loc2_:int = int(_btnGroup.selectIndex);
         switch(_loc2_)
         {
            case 0:
               if(_vipView == null)
               {
                  _vipView = ComponentFactory.Instance.creatCustomObject("vip.VIPView");
                  addToContent(_vipView);
               }
               _vipView.visible = true;
               if(_shopView != null)
               {
                  _shopView.visible = false;
               }
               break;
            case 1:
               if(_shopView == null)
               {
                  _shopView = ComponentFactory.Instance.creatCustomObject("vip.VIPShopView");
                  addToContent(_shopView);
               }
               _shopView.visible = true;
               if(_vipView != null)
               {
                  _vipView.visible = false;
               }
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _btnGroup.removeEventListener("change",__btnGroupSelectedHandler);
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         if(param1 && _btnGroup)
         {
            _btnGroup.selectIndex = int(param1["type"]);
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

