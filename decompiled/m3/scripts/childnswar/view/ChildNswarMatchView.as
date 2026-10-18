package childnswar.view
{
   import childnswar.item.ChildNswarBuleItem;
   import childnswar.item.ChildNswarRedItem;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarModel;
   
   public class ChildNswarMatchView extends Sprite
   {
      
      public var _mRed:ChildNswarRedItem;
      
      public var _mBule:ChildNswarBuleItem;
      
      public var _matchVs:Bitmap;
      
      private var _redLite:TweenLite;
      
      private var _blueLite:TweenLite;
      
      private var _delayLite:TweenLite;
      
      public function ChildNswarMatchView()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,852,574);
      }
      
      private function initView() : void
      {
         _mRed = ComponentFactory.Instance.creatCustomObject("ui.childnswar.mRed");
         _mBule = ComponentFactory.Instance.creatCustomObject("ui.childnswar.mBule");
         _matchVs = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.matchVs");
         addChild(_mRed);
         addChild(_mBule);
         addChild(_matchVs);
      }
      
      public function show() : void
      {
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         _mRed.x = -this.x - _mRed.width;
         _mBule.x = this.x + _mBule.x + _mBule.width;
         _matchVs.visible = false;
         _redLite = TweenLite.to(_mRed,0.6,{
            "x":28,
            "onComplete":moveCompleteHandler
         });
         _blueLite = TweenLite.to(_mBule,0.6,{"x":128});
         _delayLite = TweenLite.delayedCall(3,dispose);
      }
      
      private function refreshView() : void
      {
         _mRed.data = model.matchOtherInfo;
         _mBule.data = model.matchSelfInfo;
      }
      
      private function get model() : ChildNswarModel
      {
         return ChildNswarManager.Instance.model;
      }
      
      private function moveCompleteHandler() : void
      {
         _matchVs.visible = true;
      }
      
      public function dispose() : void
      {
         if(_redLite)
         {
            _redLite.kill();
         }
         _redLite = null;
         if(_blueLite)
         {
            _blueLite.kill();
         }
         _blueLite = null;
         if(_delayLite)
         {
            _delayLite.kill();
         }
         _delayLite = null;
         ObjectUtils.disposeObject(_mRed);
         _mRed = null;
         ObjectUtils.disposeObject(_mBule);
         _mBule = null;
         ObjectUtils.disposeObject(_matchVs);
         _matchVs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

