package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.theseus.TheseussoulModel;
   
   public class TheseusTaoItem extends Sprite
   {
      
      public var _suitBg:Bitmap;
      
      public var _suitName:FilterFrameText;
      
      public var model:TheseussoulModel;
      
      private var _suitIdx:int;
      
      private var _suitIcon:ScaleFrameImage;
      
      private var _lockImg:Bitmap;
      
      private var _lock:Boolean = true;
      
      private var _isSelect:Boolean;
      
      private var _redImg:Image;
      
      public function TheseusTaoItem(param1:int)
      {
         super();
         _suitIdx = param1;
         initView();
      }
      
      public function get suitIdx() : int
      {
         return _suitIdx;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         _isSelect = param1;
         if(_isSelect)
         {
            _suitIcon.setFrame(2);
         }
         else
         {
            _suitIcon.setFrame(1);
         }
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _lock = param1;
         _lockImg.visible = _lock;
         if(!_lock)
         {
            this.buttonMode = true;
            addEvent();
         }
         else
         {
            this.buttonMode = false;
            removeEvent();
         }
      }
      
      private function initView() : void
      {
         _suitBg = ComponentFactory.Instance.creatBitmap("asset.theseus.suitBg");
         _suitName = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.suitName");
         _suitIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.bigSuit" + _suitIdx);
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.theseus.lock");
         addChild(_suitBg);
         addChild(_suitIcon);
         addChild(_suitName);
         addChild(_lockImg);
         _suitIcon.setFrame(1);
         _suitName.text = LanguageMgr.GetTranslation("theseus.equip.suitName" + _suitIdx);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         model.currSuitIdx = _suitIdx;
      }
      
      public function refreshRed() : void
      {
         if(_lock)
         {
            return;
         }
         var _loc1_:Boolean = Boolean(model.checkOneSuitRed(_suitIdx));
         if(_loc1_)
         {
            if(!_redImg)
            {
               _redImg = ComponentFactory.Instance.creatComponentByStylename("ui.theseusTaoCell.Red");
            }
            addChild(_redImg);
         }
         else if(_redImg && _redImg.parent)
         {
            _redImg.parent.removeChild(_redImg);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_suitBg);
         _suitBg = null;
         ObjectUtils.disposeObject(_suitIcon);
         _suitIcon = null;
         ObjectUtils.disposeObject(_suitName);
         _suitName = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_redImg);
         _redImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         model = null;
      }
   }
}

