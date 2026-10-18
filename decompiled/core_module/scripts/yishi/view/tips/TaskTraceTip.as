package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   import managers.RingTaskManager;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class TaskTraceTip extends BaseTip
   {
      
      private static var _rewardList:Array = ["RewardPlayGP","RewardGold","RewardStrategy","RewardCrystal","RewardConsortiaOffer","RewardPlayerOffer"];
      
      private var _vBox:VBox;
      
      private var _nameTxt:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      private var _describeTxt:FilterFrameText;
      
      private var _gpTxt:FilterFrameText;
      
      private var _goldTxt:FilterFrameText;
      
      private var _soulTxt:FilterFrameText;
      
      private var _crystalTxt:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _offerTxt:FilterFrameText;
      
      private var _splitLine:ScaleBitmapImage;
      
      private var _rewardTxtTitle:FilterFrameText;
      
      private var _rewardTxtTitle2:FilterFrameText;
      
      private var _rewardItemName:FilterFrameText;
      
      private var _rewardItemName2:FilterFrameText;
      
      private var _itemTextList:Array;
      
      private var _taskTep:Object;
      
      private var tf:TextFormat;
      
      private var tf2:TextFormat;
      
      public function TaskTraceTip()
      {
         super();
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override protected function init() : void
      {
         super.init();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceNameVbox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceNameText");
         _line = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _gpTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _soulTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _crystalTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _offerTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _splitLine = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         _rewardTxtTitle = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
         _rewardTxtTitle2 = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
         _rewardItemName = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredItemName");
         _rewardItemName2 = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredItemName");
         addChild(_vBox);
         _vBox.spacing = 2;
         _itemTextList = [];
         tf = new TextFormat("Arial",12,"0x21fe2a");
         tf2 = new TextFormat("Arial",12,"0x21fe2a");
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:HBox = null;
         var _loc22_:int = 0;
         var _loc8_:HBox = null;
         var _loc11_:int = 0;
         var _loc24_:int = 0;
         var _loc12_:int = 0;
         var _loc18_:GoodsInfo = null;
         var _loc20_:TaskTraceRewardItem = null;
         var _loc23_:RingTask = null;
         var _loc10_:HBox = null;
         var _loc9_:int = 0;
         var _loc26_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc14_:int = 0;
         var _loc17_:GoodsInfo = null;
         var _loc2_:TaskTraceRewardItem = null;
         var _loc19_:GoodsInfo = null;
         var _loc7_:GoodsInfo = null;
         var _loc3_:TaskTraceRewardItem = null;
         var _loc27_:TaskTraceRewardItem = null;
         var _loc13_:HBox = null;
         var _loc1_:int = 0;
         var _loc16_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc15_:TaskTraceRewardItem = null;
         var _loc25_:int = 0;
         if(tipData is TaskTemplate)
         {
            _taskTep = tipData as TaskTemplate;
         }
         else if(tipData is BaseOfferReward)
         {
            _taskTep = (tipData as BaseOfferReward).rewardTemp;
         }
         else if(tipData is RingTask)
         {
            _taskTep = (tipData as RingTask).ringTaskTemp;
         }
         else if(tipData is MarryTask)
         {
            _taskTep = (tipData as MarryTask).marryTaskTemp;
         }
         clean();
         var _loc28_:Boolean = false;
         var _loc21_:int = 0;
         _loc22_ = 0;
         for(; _loc22_ < _rewardList.length; _loc22_++)
         {
            if(!(_taskTep.hasOwnProperty(_rewardList[_loc22_]) && int(_taskTep[_rewardList[_loc22_]]) > 0))
            {
               continue;
            }
            _loc28_ = true;
            switch(_loc22_)
            {
               case 0:
                  _loc21_ = _gpTxt.length;
                  setRewardValue(_gpTxt,_loc22_);
                  _gpTxt.setTextFormat(tf,_loc21_,_gpTxt.length);
                  _vBox.addChild(_gpTxt);
                  break;
               case 1:
                  _loc21_ = _goldTxt.length;
                  setRewardValue(_goldTxt,_loc22_);
                  _goldTxt.setTextFormat(tf,_loc21_,_goldTxt.length);
                  _vBox.addChild(_goldTxt);
                  break;
               case 2:
                  _loc21_ = _soulTxt.length;
                  setRewardValue(_soulTxt,_loc22_);
                  _soulTxt.setTextFormat(tf,_loc21_,_soulTxt.length);
                  _vBox.addChild(_soulTxt);
                  break;
               case 3:
                  _loc21_ = _crystalTxt.length;
                  setRewardValue(_crystalTxt,_loc22_);
                  _crystalTxt.setTextFormat(tf,_loc21_,_crystalTxt.length);
                  _vBox.addChild(_crystalTxt);
                  break;
               case 4:
                  _loc21_ = _consortiaTxt.length;
                  setRewardValue(_consortiaTxt,_loc22_);
                  _consortiaTxt.setTextFormat(tf,_loc21_,_consortiaTxt.length);
                  _vBox.addChild(_consortiaTxt);
                  break;
               case 5:
                  _loc21_ = _offerTxt.length;
                  setRewardValue(_offerTxt,_loc22_);
                  _offerTxt.setTextFormat(tf,_loc21_,_offerTxt.length);
                  _vBox.addChild(_offerTxt);
            }
         }
         if(_taskTep is TaskTemplate && (_taskTep as TaskTemplate).rewardItemList)
         {
            _loc8_ = new HBox();
            _loc8_.spacing = 3;
            _loc8_.x = 5;
            _loc11_ = int((_taskTep as TaskTemplate).rewardItemList.length);
            _loc24_ = 0;
            while(_loc24_ < _loc11_)
            {
               _loc12_ = int((_taskTep as TaskTemplate).rewardItemList[_loc24_].ToJob);
               if(!(_loc12_ != job && _loc12_ != 0))
               {
                  _loc18_ = new GoodsInfo();
                  _loc18_.templateId = (_taskTep as TaskTemplate).rewardItemList[_loc24_].RewardItemID;
                  _loc18_.count = (_taskTep as TaskTemplate).rewardItemList[_loc24_].RewardItemCount;
                  _loc20_ = new TaskTraceRewardItem();
                  _loc20_.data = _loc18_;
                  _loc8_.addChild(_loc20_);
               }
               _loc24_++;
            }
            if(_loc8_.numChildren > 0)
            {
               if(_loc28_)
               {
                  _vBox.addChild(_splitLine);
                  _vBox.addChild(_rewardTxtTitle);
                  _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardItem");
               }
               _vBox.addChild(_loc8_);
               _loc6_ = _loc8_;
            }
         }
         else if(tipData is RingTask)
         {
            _loc23_ = tipData as RingTask;
            _loc10_ = new HBox();
            _loc10_.spacing = 3;
            _loc10_.x = 5;
            if(_loc23_.rewardGoodsList && _loc23_.rewardGoodsList.length > 0)
            {
               _loc9_ = int(_loc23_.rewardGoodsList.length);
               _loc26_ = 0;
               while(_loc26_ < _loc9_)
               {
                  _loc5_ = _loc23_.rewardGoodsList[_loc26_];
                  _loc14_ = _loc5_.count;
                  _loc17_ = new GoodsInfo();
                  if(!RingTaskManager.instance.getRingTask())
                  {
                     _loc14_ = _loc5_.count * 16;
                  }
                  _loc17_.templateId = _loc5_.templateId;
                  _loc17_.count = _loc14_;
                  _loc2_ = new TaskTraceRewardItem();
                  _loc2_.data = _loc17_;
                  _loc10_.addChild(_loc2_);
                  _loc26_++;
               }
            }
            _vBox.addChild(_splitLine);
            if(_loc10_.numChildren > 0)
            {
               _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardItem01");
            }
            else
            {
               _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardItem02");
            }
            _vBox.addChild(_rewardTxtTitle);
            _loc19_ = RingTaskManager.instance.getRewardGoods(50)[0] as GoodsInfo;
            _loc7_ = RingTaskManager.instance.getRewardGoods(200)[0] as GoodsInfo;
            _loc3_ = new TaskTraceRewardItem();
            _loc27_ = new TaskTraceRewardItem();
            _loc3_.data = _loc19_;
            _loc27_.data = _loc7_;
            _loc10_.addChild(_loc3_);
            _loc10_.addChild(_loc27_);
            _vBox.addChild(_loc10_);
            _loc6_ = _loc10_;
         }
         else if(tipData is MarryTask)
         {
            if(_taskTep is OfferRewardTemplate && (_taskTep as OfferRewardTemplate).rewardItemList)
            {
               _loc13_ = new HBox();
               _loc13_.spacing = 3;
               _loc13_.x = 5;
               _loc1_ = 0;
               while(_loc1_ < (_taskTep as OfferRewardTemplate).rewardItemList.length)
               {
                  _loc16_ = int((_taskTep as OfferRewardTemplate).rewardItemList[_loc1_].ToJob);
                  if(!(_loc16_ != job && _loc16_ != 0))
                  {
                     _loc4_ = new GoodsInfo();
                     _loc4_.templateId = (_taskTep as OfferRewardTemplate).rewardItemList[_loc24_].RewardItemID;
                     _loc4_.count = (_taskTep as OfferRewardTemplate).rewardItemList[_loc24_].RewardItemCount;
                     _loc15_ = new TaskTraceRewardItem();
                     _loc15_.data = _loc4_;
                     _loc13_.addChild(_loc15_);
                  }
                  _loc1_++;
               }
               if(_loc13_.numChildren > 0)
               {
                  if(_loc28_)
                  {
                     _vBox.addChild(_splitLine);
                     _vBox.addChild(_rewardTxtTitle);
                     _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardItem");
                  }
                  _vBox.addChild(_loc13_);
                  _loc6_ = _loc13_;
               }
            }
         }
         _vBox.refreshChildPos();
         _bg.height = _vBox.height + _vBox.y + 4;
         _nameTxt.width = 105;
         _bg.width = 160;
         if(_nameTxt.textWidth >= _nameTxt.width)
         {
            _nameTxt.width = _nameTxt.textWidth + 10;
            _bg.width = _nameTxt.width + 10;
         }
         if(_itemTextList.length > 0)
         {
            _loc25_ = 0;
            while(_loc25_ < _itemTextList.length)
            {
               if(_itemTextList[_loc25_] is FilterFrameText)
               {
                  if(_itemTextList[_loc25_].textWidth >= _itemTextList[_loc25_].width)
                  {
                     _itemTextList[_loc25_].width = _itemTextList[_loc25_].textWidth + 2;
                     _bg.width = _itemTextList[_loc25_].width + 15;
                  }
               }
               _loc25_++;
            }
         }
         if(_line)
         {
            _line.width = 110;
         }
         if(_splitLine)
         {
            _splitLine.width = 110;
         }
         if(_bg.width < _vBox.width)
         {
            _bg.width = _vBox.width + 10;
            if(_line)
            {
               _line.width = _bg.width - 3;
            }
            if(_splitLine)
            {
               _splitLine.width = _bg.width - 3;
            }
         }
         if(_loc6_ && _loc6_.numChildren == 1)
         {
            _loc6_.x = int((_bg.width - _loc6_.width) * 0.5);
         }
         if(_vBox.numChildren <= 3)
         {
            visible = false;
         }
         else
         {
            visible = true;
         }
         _nameTxt.width = _nameTxt.textWidth + 10;
         _bg.width = _bg.width > _vBox.width + 20 ? _bg.width : _vBox.width + 20;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function get job() : int
      {
         var _loc1_:int = PlayerManager.instance.currentPlayerModel.playerInfo.job;
         if(_loc1_ > 3)
         {
            _loc1_ -= 3;
         }
         return _loc1_;
      }
      
      private function setRewardValue(param1:FilterFrameText, param2:int) : void
      {
         var _loc3_:int = 0;
         if(_taskTep is TaskTemplate)
         {
            if(_taskTep.TemplateType == 1 && param2 == 0)
            {
               param1.appendText((int(_taskTep[_rewardList[param2]]) + (thane.grades - _taskTep.NeedMinLevel) * 500).toString());
            }
            else
            {
               param1.appendText(_taskTep[_rewardList[param2]].toString());
            }
         }
         else if(_taskTep is OfferRewardTemplate)
         {
            if(tipData is BaseOfferReward)
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.isChangeJob ? 80 : thane.vocationGrades);
               if((tipData as BaseOfferReward).profile != 5)
               {
                  param1.appendText((int(_taskTep[_rewardList[param2]]) * (tipData as BaseOfferReward).profile * (thane.grades + _loc3_)).toString());
               }
               else
               {
                  param1.appendText((int(_taskTep[_rewardList[param2]]) * ((tipData as BaseOfferReward).profile + 1) * (thane.grades + _loc3_)).toString());
               }
            }
            else if(tipData is RingTask || tipData is MarryTask)
            {
               param1.appendText(_taskTep[_rewardList[param2]]);
            }
         }
      }
      
      private function clean() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = 0;
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         _vBox.removeAllChild();
         _nameTxt.text = tipData.Title;
         _describeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.describeTxt");
         _gpTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.gpTxt");
         _goldTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.goldTxt");
         _soulTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.soulTxt");
         _crystalTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.crystalTxt");
         _consortiaTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.consortiaTxt");
         _offerTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.offerTxt");
         _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardTitle1");
         _rewardTxtTitle2.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardTitle2");
         if(ArmyManager.instance.thane.grades >= 35)
         {
            _loc2_ = int(RingTaskManager.instance.getAllRingTaskGoodsReward()[1].RewardItemID);
            _rewardItemName.text = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_).TemplateName;
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_).profileColor;
            tf2.color = _loc1_;
            _rewardItemName.setTextFormat(tf2);
            _loc4_ = int(RingTaskManager.instance.getAllRingTaskGoodsReward()[2].RewardItemID);
            _rewardItemName2.text = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_).TemplateName;
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_).profileColor;
            tf2.color = _loc3_;
            _rewardItemName2.setTextFormat(tf2);
         }
         cleanList();
         _vBox.addChild(_nameTxt);
         _vBox.addChild(_line);
         _vBox.addChild(_describeTxt);
      }
      
      private function cleanList() : void
      {
         while(_itemTextList.length > 0)
         {
            (_itemTextList.pop() as FilterFrameText).dispose();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_describeTxt);
         _describeTxt = null;
         ObjectUtils.disposeObject(_gpTxt);
         _gpTxt = null;
         ObjectUtils.disposeObject(_goldTxt);
         _goldTxt = null;
         ObjectUtils.disposeObject(_soulTxt);
         _soulTxt = null;
         ObjectUtils.disposeObject(_crystalTxt);
         _crystalTxt = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_offerTxt);
         _offerTxt = null;
         cleanList();
         _itemTextList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

