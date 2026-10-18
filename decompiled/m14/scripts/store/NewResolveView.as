package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import mvc.controler.StoreControler;
   import store.treasure.TreasureResolveView;
   import yishi.datas.VersionSwitch;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RoyaltyBossManager;
   
   public class NewResolveView extends Component
   {
      
      private var _propBtn:SelectedIconButton;
      
      private var _theseusBtn:SelectedIconButton;
      
      private var _avengerBtn:SelectedIconButton;
      
      private var _treasureBtn:SelectedIconButton;
      
      private var _line:Bitmap;
      
      private var _propView:ResolveView1;
      
      private var _avengerView:AvengerRosolveView;
      
      private var _theseusView:TheseusRosolveView;
      
      private var _treasureView:TreasureResolveView;
      
      private var _btnGrooup:SelectedButtonGroup;
      
      private var _btnHbox:HBox;
      
      public function NewResolveView()
      {
         super();
         initView();
         addEvent();
         _btnGrooup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("NewResolveView.propBtn");
         _theseusBtn = ComponentFactory.Instance.creatComponentByStylename("NewResolveView.theseusBtn");
         _avengerBtn = ComponentFactory.Instance.creatComponentByStylename("NewResolveView.avengerBtn");
         _treasureBtn = ComponentFactory.Instance.creatComponentByStylename("NewResolveView.treasureBtn");
         _line = ComponentFactory.Instance.creatBitmap("asset.NewResolveView.line");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("NewResolveView.gBtnHbox");
         addChild(_btnHbox);
         _btnHbox.beginChanges();
         _btnHbox.addChild(_propBtn);
         _btnHbox.addChild(_theseusBtn);
         _btnHbox.addChild(_treasureBtn);
         if(VersionSwitch.AVENGER)
         {
            _btnHbox.addChild(_avengerBtn);
         }
         _btnHbox.commitChanges();
         addChild(_line);
         _btnGrooup = new SelectedButtonGroup();
         _btnGrooup.addSelectItem(_propBtn);
         _btnGrooup.addSelectItem(_theseusBtn);
         _btnGrooup.addSelectItem(_treasureBtn);
         if(VersionSwitch.AVENGER)
         {
            _btnGrooup.addSelectItem(_avengerBtn);
         }
         _avengerBtn.enable = ArmyManager.instance.thane.isAvenger;
         _theseusBtn.enable = RoyaltyBossManager.instance.model.royaltyLevel > 0;
         _treasureBtn.enable = RoyaltyBossManager.instance.model.royaltyLevel > 0;
      }
      
      private function addEvent() : void
      {
         _btnGrooup.addEventListener("change",__onBtnGroupHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btnGrooup)
         {
            _btnGrooup.removeEventListener("change",__onBtnGroupHandler);
         }
      }
      
      private function __onBtnGroupHandler(param1:Event) : void
      {
         SoundManager.instance.play("022",false,false);
         control.moveGoodsBack();
         switch(_btnGrooup.getSelectedItem())
         {
            case _propBtn:
               if(!_propView)
               {
                  _propView = ComponentFactory.Instance.creatCustomObject("NewResolveView.propView");
               }
               addChild(_propView);
               _propView.defaultView();
               ObjectUtils.disposeObject(_avengerView);
               _avengerView = null;
               ObjectUtils.disposeObject(_theseusView);
               _theseusView = null;
               ObjectUtils.disposeObject(_treasureView);
               _treasureView = null;
               break;
            case _avengerBtn:
               if(!_avengerView)
               {
                  _avengerView = ComponentFactory.Instance.creatCustomObject("NewResolveView.avengerView");
               }
               addChild(_avengerView);
               ObjectUtils.disposeObject(_propView);
               _propView = null;
               ObjectUtils.disposeObject(_theseusView);
               _theseusView = null;
               ObjectUtils.disposeObject(_treasureView);
               _treasureView = null;
               break;
            case _theseusBtn:
               if(!_theseusView)
               {
                  _theseusView = ComponentFactory.Instance.creatCustomObject("NewResolveView.theseusView");
               }
               addChild(_theseusView);
               ObjectUtils.disposeObject(_propView);
               _propView = null;
               ObjectUtils.disposeObject(_avengerView);
               _avengerView = null;
               ObjectUtils.disposeObject(_treasureView);
               _treasureView = null;
               break;
            case _treasureBtn:
               if(!_treasureView)
               {
                  _treasureView = ComponentFactory.Instance.creatCustomObject("NewResolveView.treasureView");
               }
               addChild(_treasureView);
               _treasureView.defaultView();
               ObjectUtils.disposeObject(_propView);
               _propView = null;
               ObjectUtils.disposeObject(_avengerView);
               _avengerView = null;
               ObjectUtils.disposeObject(_theseusView);
               _theseusView = null;
         }
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_theseusBtn);
         _theseusBtn = null;
         ObjectUtils.disposeObject(_avengerBtn);
         _avengerBtn = null;
         ObjectUtils.disposeObject(_treasureBtn);
         _treasureBtn = null;
         ObjectUtils.disposeObject(_propView);
         _propView = null;
         ObjectUtils.disposeObject(_avengerView);
         _avengerView = null;
         ObjectUtils.disposeObject(_theseusView);
         _theseusView = null;
         ObjectUtils.disposeObject(_treasureView);
         _treasureView = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         super.dispose();
      }
   }
}

