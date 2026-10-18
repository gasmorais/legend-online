package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class TaskItemTips extends BaseTip
   {
      
      private static var _rewardList:Array = ["RewardPlayGP","RewardGold","RewardStrategy","RewardCrystal","RewardConsortiaOffer","RewardPlayerOffer"];
      
      private var _itemIcon:BaseIconView;
      
      private var _itemNameTxt:FilterFrameText;
      
      private var _splitLine01:Bitmap;
      
      private var _rewardTipsTxt1:FilterFrameText;
      
      private var _rewardTipsTxt2:FilterFrameText;
      
      private var _showRewardTxt:FilterFrameText;
      
      private var _splitLine02:Bitmap;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _rewardTxtArray:Array;
      
      private var _condictionTxtArray:Array;
      
      private var _gpTxt:FilterFrameText;
      
      private var _goldTxt:FilterFrameText;
      
      private var _soulTxt:FilterFrameText;
      
      private var _crystalTxt:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _offerTxt:FilterFrameText;
      
      private var _taskTep:TaskTemplate;
      
      private var tf:TextFormat;
      
      private var tf2:TextFormat;
      
      public function TaskItemTips()
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
         _bg.width = 210;
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _itemIcon.x = 10;
         _itemIcon.y = -5;
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskItemTips.itemNameTxt");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine01.x = 70;
         _splitLine01.y = 55;
         _splitLine01.width = 115;
         _rewardTipsTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.TaskItemTips.rewardTipsTxt");
         _rewardTipsTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.TaskItemTips.rewardTipsTxt");
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskItemTips.tipsTxt");
         _gpTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _soulTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _crystalTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _offerTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         addChild(_itemIcon);
         addChild(_itemNameTxt);
         addChild(_splitLine01);
         addChild(_rewardTipsTxt1);
         addChild(_rewardTipsTxt2);
         addChild(_splitLine02);
         addChild(_tipsTxt);
         tf = new TextFormat("Arial",12,"0x21fe2a");
         tf2 = new TextFormat("Arial",12,"0x21fe2a");
      }
      
      override protected function updateTransform() : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:TaskCondictionTemplate = null;
         var _loc5_:FilterFrameText = null;
         var _loc4_:Boolean = false;
         var _loc1_:FilterFrameText = null;
         if(tipData)
         {
            _loc7_ = tipData as GoodsInfo;
            clean();
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc7_.templateInfo.TemplateId);
            _itemNameTxt.text = _loc7_.templateInfo.TemplateName;
            _rewardTipsTxt1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.TaskItemTips.rewardTipsTxt1");
            _loc6_ = _loc7_.templateInfo.Property1;
            _taskTep = TempleteManager.instance.taskTemplateDic[_loc6_];
            _loc3_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _taskTep.conditionList.length)
            {
               _loc8_ = _taskTep.conditionList[_loc2_];
               _loc8_.CondictionTitle;
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("tips.rewardItemTxt");
               _loc5_.text = _loc8_.CondictionTitle;
               _loc5_.x = 45;
               _loc5_.y = 100 + _loc2_ * 25;
               _loc5_.setFrame(2);
               _loc3_ += _loc5_.y + _loc5_.textHeight;
               addChild(_loc5_);
               _condictionTxtArray.push(_loc5_);
               _loc2_++;
            }
            _loc3_ += 10;
            _rewardTipsTxt2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.TaskItemTips.rewardTipsTxt2");
            _rewardTipsTxt2.y = _loc3_;
            _loc4_ = false;
            _loc2_ = 0;
            for(; _loc2_ < _rewardList.length; _loc2_++)
            {
               if(!(_taskTep.hasOwnProperty(_rewardList[_loc2_]) && int(_taskTep[_rewardList[_loc2_]]) > 0))
               {
                  continue;
               }
               _loc4_ = true;
               switch(_loc2_)
               {
                  case 0:
                     _loc3_ += 25;
                     setRewardValue(_gpTxt,_loc2_);
                     _gpTxt.setTextFormat(tf,3,_gpTxt.length);
                     addChild(_gpTxt);
                     _gpTxt.x = 45;
                     _gpTxt.y = _loc3_;
                     break;
                  case 1:
                     _loc3_ += 25;
                     setRewardValue(_goldTxt,_loc2_);
                     _goldTxt.setTextFormat(tf,3,_goldTxt.length);
                     addChild(_goldTxt);
                     _goldTxt.x = 45;
                     _goldTxt.y = _loc3_;
                     break;
                  case 2:
                     _loc3_ += 25;
                     setRewardValue(_soulTxt,_loc2_);
                     _soulTxt.setTextFormat(tf,3,_soulTxt.length);
                     addChild(_soulTxt);
                     _soulTxt.x = 45;
                     _soulTxt.y = _loc3_;
                     break;
                  case 3:
                     _loc3_ += 25;
                     setRewardValue(_crystalTxt,_loc2_);
                     _crystalTxt.setTextFormat(tf,3,_crystalTxt.length);
                     addChild(_crystalTxt);
                     _crystalTxt.x = 45;
                     _crystalTxt.y = _loc3_;
                     break;
                  case 4:
                     _loc3_ += 25;
                     setRewardValue(_consortiaTxt,_loc2_);
                     _consortiaTxt.setTextFormat(tf,5,_consortiaTxt.length);
                     addChild(_consortiaTxt);
                     _consortiaTxt.x = 45;
                     _consortiaTxt.y = _loc3_;
                     break;
                  case 5:
                     _loc3_ += 25;
                     setRewardValue(_offerTxt,_loc2_);
                     _offerTxt.setTextFormat(tf,5,_offerTxt.length);
                     addChild(_offerTxt);
                     _offerTxt.x = 45;
                     _offerTxt.y = _loc3_;
               }
            }
            _loc2_ = 0;
            while(_loc2_ < _taskTep.rewardItemList.length)
            {
               _loc3_ += 25;
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.rewardItemTxt");
               _loc1_.text = getGoodsTemp(_taskTep.rewardItemList[_loc2_].RewardItemID).TemplateName;
               _loc1_.setFrame(getGoodsTemp(_taskTep.rewardItemList[_loc2_].RewardItemID).Profile);
               _loc1_.x = 45;
               _loc1_.y = _loc3_;
               addChild(_loc1_);
               _rewardTxtArray.push(_loc1_);
               _loc2_++;
            }
            _splitLine02.y = _loc3_ + 25;
            _tipsTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.TaskItemTips.tipsTxt");
            _tipsTxt.y = _splitLine02.y + 5;
            _bg.height = _tipsTxt.y + _tipsTxt.textHeight + 15;
         }
      }
      
      private function setRewardValue(param1:FilterFrameText, param2:int) : void
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
      
      private function clean() : void
      {
         var _loc1_:int = 0;
         if(_rewardTxtArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _rewardTxtArray.length)
            {
               ObjectUtils.disposeObject(_rewardTxtArray[_loc1_]);
               _loc1_++;
            }
         }
         _rewardTxtArray = [];
         if(_condictionTxtArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _condictionTxtArray.length)
            {
               ObjectUtils.disposeObject(_condictionTxtArray[_loc1_]);
               _loc1_++;
            }
         }
         _condictionTxtArray = [];
         _gpTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.gpTxt");
         _goldTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.goldTxt");
         _soulTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.soulTxt");
         _crystalTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.crystalTxt");
         _consortiaTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.consortiaTxt");
         _offerTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.offerTxt");
      }
      
      private function getGoodsTemp(param1:int) : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_splitLine01);
         _splitLine01 = null;
         ObjectUtils.disposeObject(_rewardTipsTxt1);
         _rewardTipsTxt1 = null;
         ObjectUtils.disposeObject(_rewardTipsTxt2);
         _rewardTipsTxt2 = null;
         if(_rewardTxtArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _rewardTxtArray.length)
            {
               ObjectUtils.disposeObject(_rewardTxtArray[_loc1_]);
               _loc1_++;
            }
         }
         _rewardTxtArray = [];
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

