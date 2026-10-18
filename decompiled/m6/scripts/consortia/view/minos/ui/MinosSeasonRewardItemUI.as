package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.MinosRewardTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class MinosSeasonRewardItemUI extends Sprite
   {
      
      protected var _rpreTbg:Bitmap;
      
      protected var _ritembg:Bitmap;
      
      protected var _gjItemTxt:FilterFrameText;
      
      protected var _gjItemHbox:HBox;
      
      private var _itemList:Array = [];
      
      private var _temp:MinosRewardTempInfo;
      
      public function MinosSeasonRewardItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _rpreTbg = ComponentFactory.Instance.creatBitmap("asset.minos.rpreTbg");
         _ritembg = ComponentFactory.Instance.creatBitmap("asset.minos.ritembg");
         _gjItemTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjItemTxt");
         _gjItemHbox = ComponentFactory.Instance.creatCustomObject("ui.minos.gjItemHbox");
         addChild(_rpreTbg);
         addChild(_ritembg);
         addChild(_gjItemTxt);
         addChild(_gjItemHbox);
      }
      
      public function set temp(param1:MinosRewardTempInfo) : void
      {
         var _loc2_:String = null;
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         _temp = param1;
         if(_temp)
         {
            _loc2_ = _temp.RewardCondition;
            _loc4_ = _loc2_.split(",");
            if(_loc4_[0] == _loc4_[1])
            {
               _loc2_ = _loc4_[0];
            }
            else
            {
               _loc2_ = _loc4_.join("-");
            }
            _gjItemTxt.text = LanguageMgr.GetTranslation("minos.season.condition",_loc2_);
            _gjItemHbox.beginChanges();
            _loc3_ = 0;
            if(_temp.RewardNum1 > 0)
            {
               showRewardIcon(_loc3_,_temp.RewardItem1,_temp.RewardNum1);
               _loc3_++;
            }
            if(_temp.RewardNum2 > 0)
            {
               showRewardIcon(_loc3_,_temp.RewardItem2,_temp.RewardNum2);
               _loc3_++;
            }
            if(_temp.RewardNum3 > 0)
            {
               showRewardIcon(_loc3_,_temp.RewardItem3,_temp.RewardNum3);
               _loc3_++;
            }
            if(_temp.RewardNum4 > 0)
            {
               showRewardIcon(_loc3_,_temp.RewardItem4,_temp.RewardNum4);
               _loc3_++;
            }
            if(_temp.RewardNum5 > 0)
            {
               showRewardIcon(_loc3_,_temp.RewardItem5,_temp.RewardNum5);
               _loc3_++;
            }
            _gjItemHbox.commitChanges();
         }
      }
      
      private function showRewardIcon(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:BaseItemView = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         _gjItemHbox.addChild(_loc4_);
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = param2;
         _loc5_.count = param3;
         _loc4_.data = _loc5_;
         _itemList.push(_loc4_);
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_rpreTbg);
         _rpreTbg = null;
         ObjectUtils.disposeObject(_ritembg);
         _ritembg = null;
         ObjectUtils.disposeObject(_gjItemTxt);
         _gjItemTxt = null;
         ObjectUtils.disposeObject(_gjItemHbox);
         _gjItemHbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
   }
}

