package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MinosManager;
   import mvc.module.minos.MinosPlayerInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.MinosRewardTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class MinosGJRewardItemUI extends Sprite
   {
      
      protected var _rpreTbg:Bitmap;
      
      protected var _ritembg:Bitmap;
      
      protected var _gjItemTxt:FilterFrameText;
      
      protected var _gjItemHbox:HBox;
      
      protected var _ritembtn:BaseButton;
      
      protected var _gjHasFlg:Image;
      
      private var _itemList:Array = [];
      
      private var _temp:MinosRewardTempInfo;
      
      public function MinosGJRewardItemUI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _rpreTbg = ComponentFactory.Instance.creatBitmap("asset.minos.rpreTbg");
         _ritembg = ComponentFactory.Instance.creatBitmap("asset.minos.ritembg");
         _gjItemTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjItemTxt");
         _gjItemHbox = ComponentFactory.Instance.creatCustomObject("ui.minos.gjItemHbox");
         _ritembtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjItemBtn");
         _gjHasFlg = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjHasFlg");
         addChild(_rpreTbg);
         addChild(_ritembg);
         addChild(_gjItemTxt);
         addChild(_gjItemHbox);
         addChild(_ritembtn);
         addChild(_gjHasFlg);
         _gjHasFlg.visible = false;
         _ritembtn.visible = false;
      }
      
      private function initEvent() : void
      {
         _ritembtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _ritembtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(!_temp)
         {
            return;
         }
         MinosManager.ins.doSomething(7,_temp.Id);
      }
      
      public function updateView() : void
      {
         if(!_temp)
         {
            return;
         }
         _gjItemTxt.text = LanguageMgr.GetTranslation("minos.gj.condition",_temp.RewardCondition,mPlayinfo.feat,_temp.RewardCondition);
         var _loc1_:Array = mPlayinfo.featList;
         if(_loc1_ && _loc1_.indexOf("" + _temp.Id) != -1)
         {
            _ritembtn.visible = false;
            _gjHasFlg.visible = true;
         }
         else
         {
            _ritembtn.visible = true;
            _gjHasFlg.visible = false;
            if(mPlayinfo.feat >= int(_temp.RewardCondition))
            {
               _ritembtn.enable = true;
            }
            else
            {
               _ritembtn.enable = false;
            }
         }
      }
      
      public function set temp(param1:MinosRewardTempInfo) : void
      {
         var _loc2_:int = 0;
         _temp = param1;
         if(_temp)
         {
            _gjItemHbox.beginChanges();
            _loc2_ = 0;
            if(_temp.RewardNum1 > 0)
            {
               showRewardIcon(_loc2_,_temp.RewardItem1,_temp.RewardNum1);
               _loc2_++;
            }
            if(_temp.RewardNum2 > 0)
            {
               showRewardIcon(_loc2_,_temp.RewardItem2,_temp.RewardNum2);
               _loc2_++;
            }
            if(_temp.RewardNum3 > 0)
            {
               showRewardIcon(_loc2_,_temp.RewardItem3,_temp.RewardNum3);
               _loc2_++;
            }
            if(_temp.RewardNum4 > 0)
            {
               showRewardIcon(_loc2_,_temp.RewardItem4,_temp.RewardNum4);
               _loc2_++;
            }
            if(_temp.RewardNum5 > 0)
            {
               showRewardIcon(_loc2_,_temp.RewardItem5,_temp.RewardNum5);
               _loc2_++;
            }
            _gjItemHbox.commitChanges();
            updateView();
         }
      }
      
      private function get mPlayinfo() : MinosPlayerInfo
      {
         return MinosManager.ins.model.playInfo;
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
         ObjectUtils.disposeObject(_ritembtn);
         _ritembtn = null;
         ObjectUtils.disposeObject(_gjHasFlg);
         _gjHasFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
   }
}

