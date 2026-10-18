package map.campaign.mediator.activevehicle
{
   import com.map.vehicle.VehicleChatController;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import mainBar.ChatBar;
   import map.campaign.view.ui.activevehicle.ActiveVehicleBottomViewII;
   import map.campaign.view.ui.activevehicle.ActiveVehicleScreenEffectLayer;
   import map.campaign.view.ui.snowball.SnowBallRankView;
   import map.campaign.view.ui.snowball.SnowTopView;
   import ui.maintoolbar.MainToolBar;
   import yishi.interfaces.IMediator;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ActiveVehicleUIMediator implements IMediator
   {
      
      private var _screenEffectView:ActiveVehicleScreenEffectLayer;
      
      private var _bottomView:ActiveVehicleBottomViewII;
      
      private var _rightV2:SnowBallRankView;
      
      private var _topV2:SnowTopView;
      
      public function ActiveVehicleUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _screenEffectView = new ActiveVehicleScreenEffectLayer();
         _bottomView = new ActiveVehicleBottomViewII();
         _rightV2 = new SnowBallRankView();
         _topV2 = new SnowTopView();
         _screenEffectView.show();
         _bottomView.show();
         _rightV2.show();
         _topV2.show();
         __resizeHandler();
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event = null) : void
      {
         _screenEffectView.resize();
         _bottomView.resize();
         _rightV2.resize();
         _topV2.resize();
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         ChatBar.inBattleFlag = false;
         VehicleChatController.getInstance().dispose();
         ChatBar.instance.show();
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_rightV2);
         _rightV2 = null;
         ObjectUtils.disposeObject(_topV2);
         _topV2 = null;
         ObjectUtils.disposeObject(_screenEffectView);
         _screenEffectView = null;
         KeyBoardRegister.instance.vehicleFlag = false;
         MainToolBar.instance.poptipButtonVisible = true;
      }
   }
}

