package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.TimerUtils;
   
   public class RaceAgainstTimeUpView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _time:Sprite;
      
      private var _bm:Bitmap;
      
      private var _begin:Number = 0;
      
      public function RaceAgainstTimeUpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.raceAgainstTime.timeBack");
         _txt = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeUpView.txt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeUpView.timeTxt");
         _bm = ComponentFactory.Instance.creatBitmap("asset.battle.raceAgainstTime.num");
         _time = new Sprite();
         _time.x = 90;
         _time.y = 48;
         addChild(_back);
         addChild(_txt);
         addChild(_timeTxt);
         addChild(_time);
         _txt.text = LanguageMgr.GetTranslation("RaceAgainstTimeUpView.txt");
         _timeTxt.text = LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.min");
         _begin = playerInfo.raceAgainstTimeBegin;
         TimerUtils.addSecendTimer("TIME",1,99999,refreshView);
         refreshView();
      }
      
      private function refreshView() : void
      {
         _begin = _begin + 1;
         var _loc1_:int = _begin / 60;
         NumberViewUtils.getNumberView(_loc1_,_time,_bm.bitmapData,21,29,19,21,"0123456789:");
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         TimerUtils.removeSecendTimer("TIME");
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_bm);
         _bm = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

