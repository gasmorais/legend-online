package theseusgodhead.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.TheseusSlateTaskInfo;
   import yishi.view.community.BaseItemView;
   
   public class TheseusGodheadTaskItem extends Sprite implements Disposeable
   {
      
      private var _taskDesc:FilterFrameText;
      
      private var getBtn:TextButton;
      
      private var _info:TheseusSlateTaskInfo;
      
      private var _rewardIcon:BaseItemView;
      
      private var hasGetImage:Bitmap;
      
      private var bg:Bitmap;
      
      public function TheseusGodheadTaskItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         bg = ComponentFactory.Instance.creatBitmap("TheseusGodHeadbg.Tab_Menu1_Title1");
         _taskDesc = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.taskItemDesc");
         getBtn = ComponentFactory.Instance.creatComponentByStylename("heseusGodheadUpgradeView.taskbtnBtn");
         hasGetImage = ComponentFactory.Instance.creatBitmap("TheseusGodHeadbg.hasget");
         _rewardIcon = ComponentFactory.Instance.creatCustomObject("RavePartyScoreItemView.gItem");
         bg.width = 371;
         bg.height = 79;
         getBtn.text = LanguageMgr.GetTranslation("theseusgodhead.txt12");
         hasGetImage.x = 265;
         hasGetImage.y = 18;
         _rewardIcon.x = 220;
         _rewardIcon.scaleX = _rewardIcon.scaleY = 0.8;
         _rewardIcon.y = 20;
         addChild(bg);
         addChild(_taskDesc);
         addChild(getBtn);
         addChild(_rewardIcon);
         addChild(hasGetImage);
      }
      
      private function initEvent() : void
      {
         getBtn.addEventListener("click",__receiveHandler);
      }
      
      private function removeEvent() : void
      {
         getBtn.removeEventListener("click",__receiveHandler);
      }
      
      public function set info(param1:TheseusSlateTaskInfo) : void
      {
         var _loc2_:Array = null;
         var _loc3_:GoodsInfo = null;
         _info = param1;
         if(_info)
         {
            _taskDesc.text = _info.TaskDescription;
            _loc2_ = _info.TaskReward.split(",");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_[0];
            _loc3_.count = _loc2_[1];
            _rewardIcon.data = _loc3_;
            updateStatus();
         }
      }
      
      private function updateStatus() : void
      {
         var _loc1_:int = int(_info.state);
         if(_loc1_ == 0)
         {
            getBtn.visible = true;
            getBtn.enable = false;
            hasGetImage.visible = false;
         }
         else if(_loc1_ == 1)
         {
            getBtn.visible = true;
            getBtn.enable = true;
            hasGetImage.visible = false;
         }
         else if(_loc1_ == 2)
         {
            getBtn.visible = false;
            getBtn.enable = false;
            hasGetImage.visible = true;
         }
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(_info.state);
         if(_loc2_ != 1)
         {
            return;
         }
         if(_info)
         {
            TheseussoulManager.Instance.getMissionReward(_info.TemplateId);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_taskDesc);
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

