package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.TimeDownView;
   
   public class ConsortiaNewBossBufferTip extends BaseTip
   {
      
      private var _bufferNameTxt:FilterFrameText;
      
      private var _bufferDescTxt:FilterFrameText;
      
      private var _recoverTxt:FilterFrameText;
      
      private var _splite:Bitmap;
      
      private var _countTime:TimeDownView;
      
      public function ConsortiaNewBossBufferTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bufferNameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.consortianewBoss.bufferNameTxt");
         _bufferDescTxt = ComponentFactory.Instance.creatComponentByStylename("tips.consortianewBoss.bufferDescTxt");
         _recoverTxt = ComponentFactory.Instance.creatComponentByStylename("tips.consortianewBoss.recoverTxt");
         _countTime = ComponentFactory.Instance.creatComponentByStylename("tips.ConsortiaNewBossUpdateTime");
         _splite = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         addChild(_bufferNameTxt);
         addChild(_bufferDescTxt);
         addChild(_recoverTxt);
         addChild(_countTime);
         addChild(_splite);
         _splite.y = 35;
         addEvent();
      }
      
      private function addEvent() : void
      {
         if(_countTime)
         {
            _countTime.addEventListener("timerDown_complete",_timeCompleteHandler);
         }
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         dispose();
         ConsortiaNewBossManager.instance.model.bufferId = 0;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:Object = null;
         if(tipData)
         {
            _loc1_ = tipData as Object;
            if(!_bufferNameTxt)
            {
               init();
            }
            _bufferNameTxt.text = _loc1_.bufferName;
            _bufferNameTxt.y = 10 - 5 * (_bufferNameTxt.numLines - 1);
            _bufferDescTxt.htmlText = _loc1_.bufferDesc;
            if(_loc1_.needCount == false)
            {
               _recoverTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.disableTimeTxt2");
               _countTime.timeCount = _loc1_.leftTime;
               _countTime.stopTimer();
               _countTime.x = 210;
               _recoverTxt.x = 130;
            }
            else
            {
               _recoverTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.disableTimeTxt");
               _countTime.timeCount = _loc1_.leftTime - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               _countTime.x = 210;
               _recoverTxt.x = 120;
            }
            _bg.width = 271;
            _bg.height = 121;
         }
      }
      
      override public function dispose() : void
      {
         _bufferNameTxt = null;
         _bufferDescTxt = null;
         _countTime = null;
         _recoverTxt = null;
         _splite = null;
         super.dispose();
      }
   }
}

