package theseusDoublepvpscene
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.RoomManager;
   import theseusDoublepvpscene.view.TheseusAnteroomView;
   import theseusDoublepvpscene.view.TheseusDoublePvpLeftView;
   import theseusDoublepvpscene.view.TheseusDoublepvpSceneRightView;
   import theseusDoublepvpscene.view.TheseusRoomReadyTopView;
   
   public class TheseusDoubleRoomView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _rightView:TheseusDoublepvpSceneRightView;
      
      private var _anteroom:TheseusAnteroomView;
      
      private var _topView:TheseusRoomReadyTopView;
      
      private var _leftView:TheseusDoublePvpLeftView;
      
      private var _blackGound:Sprite;
      
      public function TheseusDoubleRoomView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.doublesceneMap");
         _rightView = ComponentFactory.Instance.creatCustomObject("theseusDoublepvpscene.view.TheseusDoublepvpSceneRightView");
         _anteroom = ComponentFactory.Instance.creatCustomObject("theseusDoublepvpscene.view.TheseusAnteroomView",[RoomManager.instance.roomInfo]);
         _topView = ComponentFactory.Instance.creatCustomObject("theseusDoublepvpscene.view.TheseusRoomReadyTopView");
         _leftView = ComponentFactory.Instance.creatCustomObject("theseusDoublepvpscene.view.TheseusDoublePvpLeftView");
         _blackGound = new Sprite();
         addChild(_blackGound);
         addChild(_bg);
         addChild(_anteroom);
         addChild(_rightView);
         addChild(_leftView);
         addChild(_topView);
      }
      
      private function __updateRoomMap(param1:RoomEvent) : void
      {
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc3_:int = 1495;
         var _loc4_:int = 895;
         _bg.width = param1;
         _bg.height = param2;
         _bg.x = (param1 - _bg.width) * 0.5;
         _anteroom.resize(param1,param2);
         _topView.resize(param1,param2);
         _rightView.resize(param1,param2);
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,1);
         _blackGound.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         _blackGound.graphics.endFill();
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         if(_anteroom)
         {
            ObjectUtils.disposeObject(_anteroom);
         }
         _anteroom = null;
         if(_blackGound)
         {
            ObjectUtils.disposeObject(_blackGound);
         }
         _blackGound = null;
         if(_topView)
         {
            ObjectUtils.disposeObject(_topView);
         }
         _topView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

