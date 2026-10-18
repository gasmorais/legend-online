package mainBar.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.manager.ArmyManager;
   import yishi.view.tools.SimpleMovie;
   
   public class AppellGetView extends Sprite implements Disposeable
   {
      
      private var _currentTitle:GradientText;
      
      private var _tips:MovieClip;
      
      private var _effect:SimpleMovie;
      
      public function AppellGetView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _currentTitle = ComponentFactory.Instance.creatComponentByStylename("appell.AppellFrame.CurrentTitle");
         _currentTitle.x = -20.65;
         _currentTitle.y = -9;
         _tips = ComponentFactory.Instance.creat("appell.GetTitleTips");
         _effect = new SimpleMovie(_tips,null,1,1,enterFrameHandler);
         _effect.x = 241.6;
         _effect.y = -170;
         addChild(_effect);
         _currentTitle.text = ArmyManager.instance.thane.appellInfo.Title;
      }
      
      private function initEvents() : void
      {
         _effect.addEventListener("complete",__effectCompleteHandler);
      }
      
      private function removeEvents() : void
      {
         if(_effect)
         {
            _effect.removeEventListener("complete",__effectCompleteHandler);
         }
      }
      
      private function __effectCompleteHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function enterFrameHandler() : void
      {
         if(_tips && _tips.currentFrame == 7 && _tips.title)
         {
            _tips.title.addChild(_currentTitle);
         }
      }
      
      public function show() : void
      {
         x = (StageReferance.stageWidth - width) / 2;
         y = StageReferance.stageHeight - height;
         LayerManager.Instance.addToLayer(this,2,false,false,0,2);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_currentTitle);
         _currentTitle = null;
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

