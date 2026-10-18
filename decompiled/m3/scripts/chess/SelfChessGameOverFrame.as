package chess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.chess.SelfChessGameoverInfo;
   import mvc.module.chess.SelfChessManager;
   import yishi.SwitchPageHelp;
   import yishi.view.base.NumberBitmap;
   
   public class SelfChessGameOverFrame extends Frame
   {
      
      public var _gameOverGoldTxt:FilterFrameText;
      
      public var _overGold:Image;
      
      public var _overMbg:MutipleImage;
      
      private var _idxBit:NumberBitmap;
      
      private var _sp:Sprite;
      
      private var _bg:Bitmap;
      
      private var _btn:TextButton;
      
      public function SelfChessGameOverFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _sp = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.selfchess.overBigG");
         _gameOverGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.gameOverGoldTxt");
         _overGold = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.overGold");
         _overMbg = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.overMbg");
         _idxBit = ComponentFactory.Instance.creatCustomObject("ui.selfchess.overIdxBit");
         _idxBit.initParams("asset.selfchess.over.idx","asset.selfchess.yellow",18,23,15,18,"0123456789",62,3,0,37);
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.overConfirmBtn");
         addToContent(_sp);
         _sp.addChild(_bg);
         _sp.addChild(_gameOverGoldTxt);
         _sp.addChild(_overGold);
         _sp.addChild(_overMbg);
         _sp.addChild(_idxBit);
         _sp.addChild(_btn);
         titleText = LanguageMgr.GetTranslation("selfchess.gameover.title");
         _btn.text = LanguageMgr.GetTranslation("public.confirm");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _btn.addEventListener("click",clickHandle);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _btn.removeEventListener("click",clickHandle);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function show(param1:SelfChessGameoverInfo) : void
      {
         if(param1)
         {
            _idxBit.num = param1.rank;
            _gameOverGoldTxt.text = "" + param1.score;
         }
         LayerManager.Instance.addToLayer(this,2,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["POPUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_gameOverGoldTxt);
         _gameOverGoldTxt = null;
         ObjectUtils.disposeObject(_overGold);
         _overGold = null;
         ObjectUtils.disposeObject(_overMbg);
         _overMbg = null;
         ObjectUtils.disposeObject(_idxBit);
         _idxBit = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         super.dispose();
         SelfChessManager.Ins.exitGame();
         SwitchPageHelp.returnToSpace();
      }
   }
}

