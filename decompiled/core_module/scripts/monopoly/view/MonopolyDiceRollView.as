package monopoly.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   import managers.MonopolyManager;
   import mvc.module.monopoly.MonopolyModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.tools.QuickenMovieClip;
   
   public class MonopolyDiceRollView extends Sprite implements Disposeable
   {
      
      private var _diceRollMC:MovieClip;
      
      private var _diceRollView:QuickenMovieClip;
      
      private var _diceRollResult:ScaleFrameImage;
      
      private var _callBack:Function;
      
      private var _model:MonopolyModel;
      
      public function MonopolyDiceRollView(param1:Function = null)
      {
         super();
         _callBack = param1;
         _model = MonopolyManager.instance.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _diceRollMC = ComponentFactory.Instance.creatCustomObject("monopoly.DiceRollMC");
         _diceRollView = new QuickenMovieClip(_diceRollMC);
         _diceRollResult = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceRollResult");
         _diceRollView.gotoAndStop(0);
         _diceRollView.addFrameScript(_diceRollView.totalFrames - 1,diceRollViewPlayComplete);
         addChild(_diceRollView);
         addChild(_diceRollResult);
         _diceRollView.visible = true;
         _diceRollResult.visible = false;
         _diceRollResult.setFrame(1);
      }
      
      private function diceRollViewPlayComplete() : void
      {
         _diceRollView.gotoAndStop(0);
         _diceRollResult.setFrame(_model.resultPoint);
         _diceRollView.visible = false;
         _diceRollResult.visible = true;
         setTimeout(dispose,1000);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_diceRollMC);
         _diceRollMC = null;
         ObjectUtils.disposeObject(_diceRollView);
         _diceRollView = null;
         ObjectUtils.disposeObject(_diceRollResult);
         _diceRollResult = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,2,true,true,1);
         if(_diceRollView)
         {
            _diceRollView.play();
         }
      }
      
      public function dispose() : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

