package map.campaign.mediator.singlecampaign
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import map.campaign.mediator.mapview.CampaignSmallMapMediator;
   import yishi.manager.MediatorMananger;
   
   public class SingleCampaignMapView extends Component
   {
      
      public static const NAME:String = "map.campaign.mediator.singlecampaign.SingleCampaignMapView";
      
      private var _mediatorKey:String;
      
      private var _blackBack:Component;
      
      private var _mapBack:Bitmap;
      
      private var _uiView:SingleCampaignUIView;
      
      public function SingleCampaignMapView()
      {
         super();
         initView();
         addEvent();
         __resizeHanlder(null);
      }
      
      private function initView() : void
      {
         _blackBack = new Component();
         _mapBack = ComponentFactory.Instance.creatBitmap("asset.SingleCampaignMapView.map");
         _uiView = new SingleCampaignUIView();
         addChild(_blackBack);
         addChild(_mapBack);
         addChild(_uiView);
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _mediatorKey = MediatorMananger.instance.registerMediatorList([CampaignSmallMapMediator],this,"map.campaign.mediator.singlecampaign.SingleCampaignMapView");
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc3_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         setBack(_loc3_,_loc2_);
         width = _loc3_;
         height = _loc2_;
         _mapBack.x = (_loc3_ - 1400) / 2 > 0 ? (_loc3_ - 1400) / 2 : 0;
         _mapBack.y = (_loc2_ - 900) / 2 > 0 ? (_loc2_ - 900) / 2 : 0;
         _uiView.resizeView(_loc3_,_loc2_);
      }
      
      private function setBack(param1:int, param2:int) : void
      {
         if(!_blackBack)
         {
            return;
         }
         _blackBack.graphics.clear();
         _blackBack.graphics.beginFill(0,1);
         _blackBack.graphics.drawRect(0,0,param1,param1);
         _blackBack.graphics.endFill();
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         if(_blackBack)
         {
            _blackBack.graphics.clear();
            ObjectUtils.disposeObject(_blackBack);
            _blackBack = null;
         }
         ObjectUtils.disposeObject(_mapBack);
         _mapBack = null;
         ObjectUtils.disposeObject(_uiView);
         _uiView = null;
         super.dispose();
      }
   }
}

