package simplegame.hamster
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yishi.keyboard.KeyBoardRegister;
   
   public class HamsterGameFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _closeBtn:BaseButton;
      
      private var _restartBtn:IconButton;
      
      private var _hamsterGame:HamsterGame;
      
      private var _gameTime:int;
      
      private var _gameScore:int;
      
      private var _callBack:Function;
      
      public function HamsterGameFrame(param1:int, param2:int, param3:Function = null)
      {
         super();
         _gameTime = param1;
         _gameScore = param2;
         _callBack = param3;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _restartBtn = ComponentFactory.Instance.creatComponentByStylename("task.hamsterRestartBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("task.hamsterCloseBtn");
         _hamsterGame = new HamsterGame(_gameTime,_gameScore,_successCallBack,_gameLostHandler);
         addChild(_hamsterGame);
         addChild(_closeBtn);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         _hamsterGame.gameStart();
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
         _restartBtn.addEventListener("click",__restartGame);
      }
      
      private function _successCallBack() : void
      {
         dispose();
         _callBack();
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         if(_hamsterGame.scoreCount >= _gameScore)
         {
            _callBack();
         }
         dispose();
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__closeHandler);
         _restartBtn.removeEventListener("click",__restartGame);
      }
      
      private function __restartGame(param1:MouseEvent) : void
      {
         _hamsterGame.gameStart();
         if(_restartBtn.parent)
         {
            removeChild(_restartBtn);
         }
      }
      
      private function _gameLostHandler() : void
      {
         addChild(_restartBtn);
      }
      
      public function hideClose() : void
      {
         _closeBtn.visible = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,620,345);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_hamsterGame);
         _hamsterGame = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_restartBtn);
         _restartBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get closeBtn() : BaseButton
      {
         return _closeBtn;
      }
   }
}

