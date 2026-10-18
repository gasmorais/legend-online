package registwelfare
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.registwelfare.SimpleTaskInfo;
   import mvc.module.registwelfare.SimpleTaskRecordInfo;
   import mvc.module.registwelfare.SimpleTaskRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.RegistWelfareManager;
   import yishi.view.community.BaseItemView;
   
   public class RegistWelfareItem extends Component implements Disposeable
   {
      
      private var _bg:DisplayObject;
      
      private var _rewardDesBg:DisplayObject;
      
      private var _rewardTitleTxt:FilterFrameText;
      
      private var _rewardDesTxt:FilterFrameText;
      
      private var _rewardNeedTxt:FilterFrameText;
      
      private var _increasePointTxt:FilterFrameText;
      
      private var _increasePointImg:DisplayObject;
      
      private var _increaseCanTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _receiveBtn1:TextButton;
      
      private var _receiveBtn2:TextButton;
      
      private var _data:SimpleTaskInfo;
      
      public function RegistWelfareItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.registwelfare.taskBg");
         _rewardDesBg = ComponentFactory.Instance.creatComponentByStylename("registwelfare.taskDesBg");
         _rewardTitleTxt = ComponentFactory.Instance.creatComponentByStylename("registwelfare.rewardTitleTxt");
         _rewardDesTxt = ComponentFactory.Instance.creatComponentByStylename("registwelfare.rewardDesTxt");
         _rewardNeedTxt = ComponentFactory.Instance.creatComponentByStylename("registwelfare.increaseNeedTxt");
         _increasePointTxt = ComponentFactory.Instance.creatComponentByStylename("registwelfare.increasePointTxt");
         _increasePointImg = ComponentFactory.Instance.creatComponentByStylename("registwelfare.increasePointImg");
         _increaseCanTxt = ComponentFactory.Instance.creatComponentByStylename("registwelfare.increaseCanTxt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("registwelfare.rewardHbox");
         _receiveBtn1 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.taskReceiveBtn1");
         _receiveBtn2 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.taskReceiveBtn2");
         addChild(_bg);
         addChild(_rewardTitleTxt);
         addChild(_rewardDesBg);
         addChild(_rewardDesTxt);
         addChild(_rewardNeedTxt);
         addChild(_increasePointTxt);
         addChild(_increasePointImg);
         addChild(_increaseCanTxt);
         addChild(_hBox);
         addChild(_receiveBtn1);
         addChild(_receiveBtn2);
         _rewardNeedTxt.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.needNote");
         _increaseCanTxt.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.increaseCan");
         _receiveBtn1.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.receiveBtn1");
         _receiveBtn2.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.receiveBtn2");
      }
      
      private function addEvent() : void
      {
         _receiveBtn1.addEventListener("click",__receiveHandler);
         _receiveBtn2.addEventListener("click",__increaseHandler);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn1.removeEventListener("click",__receiveHandler);
         _receiveBtn2.removeEventListener("click",__increaseHandler);
      }
      
      public function set data(param1:SimpleTaskRecordInfo) : void
      {
         var _loc2_:Array = null;
         var _loc4_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:SimpleTaskRewardInfo = null;
         var _loc6_:int = 0;
         _data = RegistWelfareManager.instance.getSimpleTaskDic(param1.taskId);
         _rewardNeedTxt.visible = param1.taskState == 2;
         _increasePointTxt.visible = param1.taskState == 2;
         _increasePointImg.visible = param1.taskState == 2;
         _increaseCanTxt.visible = param1.taskState == 2;
         _receiveBtn1.visible = param1.taskState != 2;
         _receiveBtn1.enable = param1.taskState == 1;
         _receiveBtn2.visible = param1.taskState == 2;
         _rewardDesTxt.text = _data.detail;
         _increasePointTxt.text = _data.extraRewardCost.toString();
         if(param1.taskState == 2)
         {
            _loc2_ = _data.extraReward;
            _rewardTitleTxt.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareItem.rewardTitleTxt2");
         }
         else
         {
            _loc2_ = _data.generalReward;
            _rewardTitleTxt.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareItem.rewardTitleTxt1");
         }
         _hBox.disposeAllChildren();
         _hBox.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc6_];
            if(_loc3_.toJob == 0 || _loc3_.toJob == ArmyManager.instance.thane.templateInfo.Job)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("registwelfare.iconRewardView");
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc3_.rewardItemID;
               _loc5_.count = _loc3_.rewardItemCount;
               _loc4_.data = _loc5_;
               _hBox.addChild(_loc4_);
            }
            _loc6_++;
         }
         _hBox.commitChanges();
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RegistWelfareManager.instance.receiveHandler(_data.taskId,1);
      }
      
      private function __increaseHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RegistWelfareManager.instance.increaseHandler(_data.taskId,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rewardDesBg);
         _rewardDesBg = null;
         ObjectUtils.disposeObject(_rewardTitleTxt);
         _rewardTitleTxt = null;
         ObjectUtils.disposeObject(_rewardDesTxt);
         _rewardDesTxt = null;
         ObjectUtils.disposeObject(_rewardNeedTxt);
         _rewardNeedTxt = null;
         ObjectUtils.disposeObject(_increasePointTxt);
         _increasePointTxt = null;
         ObjectUtils.disposeObject(_increasePointImg);
         _increasePointImg = null;
         ObjectUtils.disposeObject(_increaseCanTxt);
         _increaseCanTxt = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_receiveBtn1);
         _receiveBtn1 = null;
         ObjectUtils.disposeObject(_receiveBtn2);
         _receiveBtn2 = null;
         _data = null;
         super.dispose();
      }
   }
}

