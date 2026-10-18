package sqmemory.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SqmemoryItem extends Sprite
   {
      
      private var _timeIcon:Bitmap;
      
      private var _timebg:Bitmap;
      
      private var _des:FilterFrameText;
      
      private var _type:int;
      
      private var _lineHeight:int = 20;
      
      public function SqmemoryItem(param1:int = 1)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         if(_type == 0)
         {
            _des = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.des");
         }
         else if(_type == 1)
         {
            _timeIcon = ComponentFactory.Instance.creatBitmap("asset.sqmemory.timeIcon");
            _timebg = ComponentFactory.Instance.creatBitmap("asset.sqmemory.timebg");
            addChild(_timebg);
            addChild(_timeIcon);
            _des = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.des");
         }
         else if(_type == 2)
         {
            _timeIcon = ComponentFactory.Instance.creatBitmap("asset.sqmemory.timeIcon");
            addChild(_timeIcon);
            _des = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.des");
         }
         else if(_type == -999)
         {
            _timeIcon = ComponentFactory.Instance.creatBitmap("asset.sqmemory.timeIcon");
            addChild(_timeIcon);
            _des = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.shareDesTest");
            _lineHeight = 20;
         }
         else
         {
            _timeIcon = ComponentFactory.Instance.creatBitmap("asset.sqmemory.point");
            addChild(_timeIcon);
            _des = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.des2");
         }
         addChild(_des);
      }
      
      public function getContentStr() : String
      {
         if(!_des)
         {
            return "";
         }
         return _des.text;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_timeIcon);
         _timeIcon = null;
         ObjectUtils.disposeObject(_timebg);
         _timebg = null;
         ObjectUtils.disposeObject(_des);
         _des = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function updateView(param1:String) : void
      {
         _des.htmlText = param1;
         _des.height = _des.numLines * _lineHeight;
      }
      
      public function changeDesHeight(param1:int) : void
      {
         _des.height = param1;
      }
      
      public function addImage(param1:Bitmap) : void
      {
         addChildAt(param1,0);
      }
   }
}

