package battle.view.reinforce
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import yishi.datas.BattleModel;
   
   public class ReinforceWaveBall extends Component
   {
      
      private var _mc:MovieClip;
      
      private var _removeFun:Function;
      
      private var _tipInfo:String;
      
      private var _back:Bitmap;
      
      public function ReinforceWaveBall(param1:Function, param2:String = "", param3:int = 0)
      {
         _removeFun = param1;
         _tipInfo = param2;
         if(battleModel.battleType == 3886)
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.battle.EastReinforceFlagBg");
            _mc = ComponentFactory.Instance.creat("asset.battle.EastReinforceMC" + param3);
            _back.x = -19;
            _back.y = -15;
         }
         else
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.battle.ReinforceFlagBg");
            _mc = ComponentFactory.Instance.creat("asset.battle.ReinforceMC");
            _back.x = -49;
            _back.y = -30;
         }
         addChild(_back);
         _mc.addFrameScript(_mc.totalFrames - 1,lastFrameFun);
         addChild(_mc);
         super();
         tipStyle = "yishi.view.tips.OneLineTip";
         tipData = _tipInfo;
         isFollowMouse = false;
         tipDirctions = "3,6,7";
         tipGapV = 10;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function lastFrameFun() : void
      {
         _mc.stop();
         if(_mc.parent)
         {
            _mc.parent.removeChild(_mc);
         }
         if(_back)
         {
            _back.visible = false;
         }
      }
      
      public function exit() : void
      {
         _mc.gotoAndPlay("exit");
      }
      
      override public function dispose() : void
      {
         if(_mc)
         {
            ObjectUtils.disposeObject(_mc);
         }
         _mc = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         _removeFun = null;
         super.dispose();
      }
   }
}

