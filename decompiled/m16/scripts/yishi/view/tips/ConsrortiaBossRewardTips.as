package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   
   public class ConsrortiaBossRewardTips extends BaseTip
   {
      
      private var _txt:FilterFrameText;
      
      public function ConsrortiaBossRewardTips()
      {
         super();
         _txt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         _txt.x = 15;
         _txt.y = 7;
         addChild(_txt);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:String = null;
         var _loc2_:RegExp = null;
         if(tipData)
         {
            _loc1_ = tipData as String;
            _loc2_ = /\(/g;
            _loc1_ = _loc1_.replace(_loc2_,"<font color=\'#ffff00\'>");
            _loc2_ = /\[/g;
            _loc1_ = _loc1_.replace(_loc2_,"<font color=\'#00ff00\'>");
            _loc2_ = /\]/g;
            _loc1_ = _loc1_.replace(_loc2_,"</font>");
            _loc2_ = /\)/g;
            _loc1_ = _loc1_.replace(_loc2_,"</font>");
            _txt.htmlText = _loc1_;
            _bg.width = _txt.textWidth + 30;
            _bg.height = _txt.textHeight + 20;
         }
      }
   }
}

