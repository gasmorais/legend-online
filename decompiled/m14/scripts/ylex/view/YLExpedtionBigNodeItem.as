package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   
   public class YLExpedtionBigNodeItem extends Sprite
   {
      
      private var _mc:MovieClip;
      
      private var _ydFt:MutipleImage;
      
      private var levelText:FilterFrameText;
      
      public function YLExpedtionBigNodeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallTowerView.tower100Mc");
         _ydFt = ComponentFactory.Instance.creatComponentByStylename("ui.ylexdition.main.ydBigft");
         levelText = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtion.ydlvBigTxt");
         addChild(_mc);
         addChild(_ydFt);
         addChild(levelText);
         _mc.mouseEnabled = false;
         var _loc1_:int = int(ChildPatrolManager.instance.model.headQuartersInfo.level);
         levelText.text = "(" + LanguageMgr.GetTranslation("public.level2",_loc1_) + ")";
      }
      
      public function dispose() : void
      {
         if(_mc)
         {
            ObjectUtils.disposeViolentMc(_mc);
         }
         _mc = null;
         ObjectUtils.disposeObject(_ydFt);
         _ydFt = null;
         ObjectUtils.disposeObject(levelText);
         levelText = null;
      }
   }
}

