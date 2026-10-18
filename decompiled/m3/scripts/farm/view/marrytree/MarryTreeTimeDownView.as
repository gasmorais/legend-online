package farm.view.marrytree
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.view.community.TimeDownView;
   
   public class MarryTreeTimeDownView extends Sprite implements Disposeable
   {
      
      private var _timeTitle:FilterFrameText;
      
      private var _timeDown:TimeDownView;
      
      public function MarryTreeTimeDownView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _timeTitle = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.trainCountDown");
         _timeDown = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.TimeDown");
         addChild(_timeTitle);
         _timeTitle.y = 145;
         addChild(_timeDown);
         _timeDown.x = 180;
         _timeDown.y = 145;
      }
      
      public function setCount(param1:int) : void
      {
         _timeTitle.x = 81;
         if(param1 <= 0)
         {
            _timeDown.visible = false;
            _timeTitle.text = LanguageMgr.GetTranslation("marry.marryTree.canTrain");
            _timeTitle.x = 56;
            return;
         }
         _timeTitle.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.trainCountDown");
         _timeDown.visible = true;
         _timeDown.timeCount = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_timeTitle);
         _timeTitle = null;
         ObjectUtils.disposeObject(_timeDown);
         _timeDown = null;
      }
   }
}

