package theseuspvp.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.TheseusPvpTaskTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class TheseusPvpRewardItem extends Sprite implements IManualSize
   {
      
      public var _rewardHbox:HBox;
      
      public var _rewardSortIdxTxt:FilterFrameText;
      
      public var _rewardHget:Bitmap;
      
      public var _rewardItemtbg:Bitmap;
      
      public var _rewardIttx:FilterFrameText;
      
      private var _temp:TheseusPvpTaskTempInfo;
      
      private var _rect:Rectangle = new Rectangle(0,0,527,98);
      
      private var _data:TheseusPvpRewardInfo;
      
      private var _getBtn:BaseButton;
      
      private var _geticon:ScaleFrameImage;
      
      private var _itemList:Array = [];
      
      public function TheseusPvpRewardItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      private function initView() : void
      {
         _rewardHbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.rewardHbox");
         _rewardSortIdxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardSortIdxTxt");
         _rewardHget = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.rewardHget");
         _rewardItemtbg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.rewardItemtbg");
         _rewardIttx = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardIttx");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rwGetBtn");
         _geticon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rwIconBtn");
         addChild(_rewardHbox);
         addChild(_rewardSortIdxTxt);
         addChild(_rewardHget);
         addChild(_rewardItemtbg);
         addChild(_rewardIttx);
         addChild(_getBtn);
         _getBtn.addChild(_geticon);
         _getBtn.visible = false;
         _rewardHget.visible = false;
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",getHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",getHandler);
      }
      
      private function getHandler(param1:MouseEvent) : void
      {
         if(_temp)
         {
            TheseusPvpManager.Instance.doSomething(7,_temp.Id);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_rewardSortIdxTxt);
         _rewardSortIdxTxt = null;
         ObjectUtils.disposeObject(_rewardHget);
         _rewardHget = null;
         ObjectUtils.disposeObject(_rewardItemtbg);
         _rewardItemtbg = null;
         ObjectUtils.disposeObject(_rewardIttx);
         _rewardIttx = null;
         ObjectUtils.disposeObject(_geticon);
         _geticon = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
         _data = null;
      }
      
      public function get temp() : TheseusPvpTaskTempInfo
      {
         return _temp;
      }
      
      public function set temp(param1:TheseusPvpTaskTempInfo) : void
      {
         var _loc7_:Array = null;
         var _loc2_:Array = null;
         var _loc4_:String = null;
         var _loc6_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc5_:int = 0;
         _temp = param1;
         if(_temp)
         {
            _loc7_ = _temp.Reward.split("|");
            if(_temp.Area == 3)
            {
               _getBtn.visible = false;
               _rewardHget.visible = false;
            }
            if(_temp.Area != 1)
            {
               _rewardIttx.text = _temp.Name;
            }
            _rewardHbox.beginChanges();
            _rewardHbox.removeAllChild();
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc4_ = _loc7_[_loc5_];
               if(_loc4_.length >= 2)
               {
                  _loc2_ = _loc4_.split(",");
                  _loc6_ = new GoodsInfo();
                  _loc6_.templateId = int(_loc2_[0]);
                  _loc6_.count = int(_loc2_[1]);
                  if(_loc5_ <= _itemList.length)
                  {
                     _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
                     _itemList.push(_loc3_);
                  }
                  else
                  {
                     _loc3_ = _itemList[_loc5_];
                  }
                  _loc3_.data = _loc6_;
                  _rewardHbox.addChild(_loc3_);
               }
               _loc5_++;
            }
            _rewardHbox.commitChanges();
         }
      }
      
      private function getProgress() : String
      {
         var _loc1_:String = "";
         if(_temp)
         {
            _loc1_ = "(" + _data.data + "/" + _temp.TaskNum + ")";
         }
         return _loc1_;
      }
      
      public function get data() : TheseusPvpRewardInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusPvpRewardInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _rewardHget.visible = false;
            _getBtn.visible = true;
            if(_temp.Area == 1)
            {
               _rewardIttx.text = _temp.Name + getProgress();
            }
            if(_temp.Area == 3)
            {
               return;
            }
            switch(int(_data.state))
            {
               case 0:
                  _getBtn.enable = false;
                  _geticon.setFrame(1);
                  break;
               case 1:
                  _getBtn.enable = true;
                  _geticon.setFrame(2);
                  break;
               case 2:
                  _rewardHget.visible = true;
                  _getBtn.visible = false;
            }
         }
      }
   }
}

