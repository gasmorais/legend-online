package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import map.campaign.mediator.mapview.CampaignSmallMapMediator;
   import yishi.manager.MediatorMananger;
   import yishi.utils.MsgMan;
   
   public class FantasyMatrixMapView extends Component
   {
      
      public static const NAME:String = "map.campaign.mediator.fantasymatrix.FantasyMatrixMapView";
      
      private var blackBack:Component;
      
      private var mapBack:Bitmap;
      
      private var leftView:FantasyMatrixLeftView;
      
      private var rightView:FantasyMatrixRightView;
      
      private var warView:FantasyMatrixWarView;
      
      private var _mediatorKey:String;
      
      public function FantasyMatrixMapView()
      {
         super();
         initView();
         addEvent();
         __resizeHanlder(null);
      }
      
      private function initView() : void
      {
         blackBack = new Component();
         mapBack = ComponentFactory.Instance.creatBitmap("asset.FantasyMatrixMapView.mapBack");
         leftView = ComponentFactory.Instance.creatCustomObject("FantasyMatrixMapView.leftView");
         rightView = ComponentFactory.Instance.creatCustomObject("FantasyMatrixMapView.rightView");
         warView = ComponentFactory.Instance.creatCustomObject("FantasyMatrixMapView.warView");
         addChild(blackBack);
         addChild(mapBack);
         addChild(leftView);
         addChild(rightView);
         addChild(warView);
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         MsgMan.addObserver("FANTASYMATRIX_MAIN_UPDATE",this,__updateMainHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         MsgMan.removeObserver("FANTASYMATRIX_MAIN_UPDATE",this,__updateMainHandler);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _mediatorKey = MediatorMananger.instance.registerMediatorList([CampaignSmallMapMediator],this,"map.campaign.mediator.fantasymatrix.FantasyMatrixMapView");
      }
      
      private function __updateMainHandler(param1:String, param2:Object) : void
      {
         if(leftView)
         {
            leftView.refreshView();
         }
         if(rightView)
         {
            rightView.refreshView();
         }
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc3_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         setBack(_loc3_,_loc2_);
         width = _loc3_;
         height = _loc2_;
         mapBack.x = (_loc3_ - 1400) / 2 > 0 ? (_loc3_ - 1400) / 2 : 0;
         mapBack.y = (_loc2_ - 800) / 2 > 0 ? (_loc2_ - 800) / 2 : 0;
         leftView.x = mapBack.x;
         if(_loc3_ > 1400)
         {
            rightView.x = mapBack.x + 1225;
         }
         else
         {
            rightView.x = mapBack.x + _loc3_ - 175;
         }
         warView.x = mapBack.x + 190;
         warView.y = mapBack.y;
      }
      
      private function setBack(param1:int, param2:int) : void
      {
         blackBack.graphics.clear();
         blackBack.graphics.beginFill(0,1);
         blackBack.graphics.drawRect(0,0,param1,param1);
         blackBack.graphics.endFill();
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         if(blackBack)
         {
            blackBack.graphics.clear();
            ObjectUtils.disposeObject(blackBack);
            blackBack = null;
         }
         ObjectUtils.disposeObject(mapBack);
         mapBack = null;
         ObjectUtils.disposeObject(leftView);
         leftView = null;
         ObjectUtils.disposeObject(rightView);
         rightView = null;
         ObjectUtils.disposeObject(warView);
         warView = null;
         super.dispose();
      }
   }
}

