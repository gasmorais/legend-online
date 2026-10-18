package revenge.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.RevengeRoadTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class RevengeNodeItem extends Sprite
   {
      
      public var _lock2:Bitmap;
      
      public var _chooseCard:Bitmap;
      
      public var _normalCard:Bitmap;
      
      private var _idxSp:Sprite;
      
      private var _idxData:BitmapData;
      
      private var _isShowfrist:Boolean;
      
      private var _hit:Sprite;
      
      private var _lock:Boolean;
      
      private var _isChoose:Boolean;
      
      private var _reward:BaseItemView;
      
      private var _nodeId:int;
      
      public function RevengeNodeItem()
      {
         super();
         initView();
      }
      
      public function get isChoose() : Boolean
      {
         return _isChoose;
      }
      
      public function set isChoose(param1:Boolean) : void
      {
         _isChoose = param1;
         _normalCard.visible = !_isChoose;
         _chooseCard.visible = _isChoose;
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _lock = param1;
         _lock2.visible = _lock;
         _reward.visible = !_lock;
      }
      
      public function get isShowfrist() : Boolean
      {
         return _isShowfrist;
      }
      
      public function set isShowfrist(param1:Boolean) : void
      {
         _isShowfrist = param1;
         _reward.visible = _isShowfrist;
      }
      
      private function initView() : void
      {
         _lock2 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.lock2");
         _chooseCard = ComponentFactory.Instance.creatBitmap("asset.revengeroad.unLockCard");
         _normalCard = ComponentFactory.Instance.creatBitmap("asset.revengeroad.lockCard");
         _idxData = ComponentFactory.Instance.creatBitmap("asset.revengeroad.num").bitmapData;
         _reward = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         addChild(_chooseCard);
         addChild(_normalCard);
         addChild(_lock2);
         addChild(_reward);
         _reward.x = 45;
         _reward.y = 53;
         _idxSp = new Sprite();
         addChild(_idxSp);
         _idxSp.x = 36;
         _idxSp.y = 94;
         _hit = new Sprite();
         _hit.graphics.beginFill(16711680,0);
         _hit.graphics.drawRect(21,26,105,105);
         _hit.graphics.endFill();
         _hit.mouseChildren = _hit.mouseEnabled = false;
         addChild(_hit);
         this.hitArea = _hit;
         isChoose = false;
      }
      
      public function setIdx(param1:int, param2:int) : void
      {
         var _loc3_:Array = null;
         var _loc5_:CommonDropTempInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc7_:Number = Number(param1 + "." + param2);
         NumberViewUtils.getNumberView(_loc7_,_idxSp,_idxData,25,31,20,25,".0123456789",1);
         _nodeId = (param1 - 1) * 10 + param2;
         var _loc4_:RevengeRoadTempInfo = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_nodeId);
         if(_loc4_)
         {
            _loc3_ = TempleteManager.instance.revengeRoadDropCate.getDropsById(_loc4_.FirstDropId);
            if(_loc3_ && _loc3_.length > 0)
            {
               _loc5_ = _loc3_[0];
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc5_.itemId;
               _loc6_.count = _loc5_.count;
               _reward.data = _loc6_;
            }
         }
      }
      
      public function get nodeId() : int
      {
         return _nodeId;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_lock2);
         _lock2 = null;
         ObjectUtils.disposeObject(_chooseCard);
         _chooseCard = null;
         ObjectUtils.disposeObject(_normalCard);
         _normalCard = null;
         ObjectUtils.disposeObject(_idxData);
         _idxData = null;
         ObjectUtils.disposeObject(_hit);
         _hit = null;
         ObjectUtils.disposeObject(_reward);
         _reward = null;
         ObjectUtils.disposeAllChildren(_idxSp);
         _idxSp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

