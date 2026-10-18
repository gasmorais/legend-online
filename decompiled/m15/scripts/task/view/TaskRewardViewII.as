package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.RingTaskManager;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskGoodsTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.OfferRewardGoodsTemplate;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class TaskRewardViewII extends Sprite implements Disposeable
   {
      
      private var _titleBack:Bitmap;
      
      private var _title:Bitmap;
      
      private var _title2:Bitmap;
      
      private var _vBox:VBox;
      
      private var _contain1:Sprite;
      
      private var _contain2:Sprite;
      
      private var _rewardItemList:Array;
      
      private var _goodsList:Array;
      
      private var _goodsItemPointList:Array;
      
      private var _isRing:Boolean;
      
      private var _isMarry:Boolean;
      
      private var _rewardList:Array = ["RewardPlayGP","RewardGold","RewardStrategy","RewardCrystal","RewardConsortiaOffer","RewardPlayerOffer","RewardHappy"];
      
      private var _marryTaskText:FilterFrameText;
      
      private var _baseReward:BaseOfferReward;
      
      private var _data:Object;
      
      private var _ringTask:RingTask;
      
      public function TaskRewardViewII()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:TaskRewardItem = null;
         var _loc4_:Point = null;
         var _loc2_:TaskGoodItemView = null;
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.task.TitleBack");
         _title = ComponentFactory.Instance.creatBitmap("asset.task.RewardTxt");
         _title2 = ComponentFactory.Instance.creatBitmap("asset.task.RewardTxt2");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("task.RewardViewVBox");
         _marryTaskText = ComponentFactory.Instance.creatComponentByStylename("task.marryTaskText");
         addChild(_titleBack);
         addChild(_title);
         addChild(_title2);
         _title2.visible = false;
         addChild(_vBox);
         _contain1 = new Sprite();
         _contain2 = new Sprite();
         _rewardItemList = [];
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc1_ = new TaskRewardItem();
            _loc4_ = ComponentFactory.Instance.creatCustomObject("task.TaskRewardItemPoint_" + _loc3_);
            _loc1_.x = _loc4_.x;
            _loc1_.y = _loc4_.y;
            _rewardItemList.push(_loc1_);
            _loc3_++;
         }
         _goodsItemPointList = [];
         _goodsList = [];
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _goodsItemPointList.push(ComponentFactory.Instance.creatCustomObject("task.RewardGoodItemPoint_" + _loc3_));
            _loc2_ = new TaskGoodItemView();
            _goodsList.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function set data(param1:Object) : void
      {
         _isRing = false;
         _isMarry = false;
         _title.visible = true;
         _title2.visible = false;
         if(param1 is TaskTemplate)
         {
            _data = param1 as TaskTemplate;
         }
         else if(param1 is BaseOfferReward)
         {
            _baseReward = param1 as BaseOfferReward;
            _data = (param1 as BaseOfferReward).rewardTemp;
         }
         else if(param1 is MarryTask)
         {
            _data = (param1 as MarryTask).marryTaskTemp;
            _isMarry = true;
         }
         else if(param1 is RingTask)
         {
            _ringTask = param1 as RingTask;
            _data = (param1 as RingTask).ringTaskTemp;
            if(_ringTask.ringTaskTemp.Type == 3)
            {
               _title.visible = false;
               _title2.visible = true;
               getRewardByLevel(_data);
            }
            _isRing = true;
         }
         refreshView();
      }
      
      private function getRewardByLevel(param1:*) : void
      {
         var _loc2_:int = int(ArmyManager.instance.thane.grades);
         if(_loc2_ >= 35 && _loc2_ < 45)
         {
            param1["RewardGold"] = 400000;
            param1["RewardStrategy"] = 2000000;
         }
         else if(_loc2_ >= 45 && _loc2_ < 55)
         {
            param1["RewardGold"] = 480000;
            param1["RewardStrategy"] = 2400000;
         }
         else if(_loc2_ >= 55 && _loc2_ < 65)
         {
            param1["RewardGold"] = 600000;
            param1["RewardStrategy"] = 3000000;
         }
         else if(_loc2_ >= 65 && _loc2_ < 100)
         {
            param1["RewardGold"] = 800000;
            param1["RewardStrategy"] = 4000000;
         }
      }
      
      private function refreshView() : void
      {
         _vBox.removeAllChild();
         refreshReward();
         refreshGoods();
      }
      
      private function getRewardItem() : TaskRewardItem
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _rewardItemList.length)
         {
            if(!(_rewardItemList[_loc1_] as DisplayObject).parent)
            {
               return _rewardItemList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      private function resetRewardIten() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _rewardItemList.length)
         {
            if((_rewardItemList[_loc1_] as DisplayObject).parent)
            {
               (_rewardItemList[_loc1_] as DisplayObject).parent.removeChild(_rewardItemList[_loc1_] as DisplayObject);
            }
            _loc1_++;
         }
      }
      
      private function refreshReward() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TaskRewardItem = null;
         var _loc3_:int = 0;
         resetRewardIten();
         if(!_data)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _rewardList.length)
         {
            if(_data.hasOwnProperty(_rewardList[_loc2_]) && int(_data[_rewardList[_loc2_]]) > 0)
            {
               _loc1_ = getRewardItem();
               _loc1_.propertyName = _loc2_ + 1;
               if(_data is TaskTemplate)
               {
                  if(_data.TemplateType == 1 && _loc2_ == 0)
                  {
                     _loc1_.propertyValue = (int(_data[_rewardList[_loc2_]]) + (thane.grades - _data.NeedMinLevel) * 500).toString();
                  }
                  else
                  {
                     _loc1_.propertyValue = int(_data[_rewardList[_loc2_]]).toString();
                  }
               }
               else if(_data is OfferRewardTemplate)
               {
                  if(_isRing || _isMarry)
                  {
                     _loc1_.propertyValue = int(_data[_rewardList[_loc2_]]).toString();
                  }
                  else
                  {
                     _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.isChangeJob ? 80 : thane.vocationGrades);
                     if(_baseReward.profile != 5)
                     {
                        _loc1_.propertyValue = (int(_data[_rewardList[_loc2_]]) * _baseReward.profile * (thane.grades + _loc3_)).toString();
                     }
                     else
                     {
                        _loc1_.propertyValue = (int(_data[_rewardList[_loc2_]]) * (_baseReward.profile + 1) * (thane.grades + _loc3_)).toString();
                     }
                  }
               }
               _contain1.addChild(_loc1_);
               _vBox.addChild(_contain1);
            }
            _loc2_++;
         }
      }
      
      private function resetGoodsItem() : void
      {
         for each(var _loc1_:TaskGoodItemView in _goodsList)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
      }
      
      private function refreshGoods() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc2_:TaskGoodItemView = null;
         var _loc8_:Point = null;
         var _loc6_:String = null;
         var _loc7_:ConfigInfosTempInfo = null;
         resetGoodsItem();
         var _loc1_:Array = getTaskGoodList(_data);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         for(; _loc4_ < _loc3_; _contain2.addChild(_loc2_),_vBox.addChild(_contain2),_loc4_++)
         {
            _loc5_ = _loc1_[_loc4_];
            _loc2_ = _goodsList[_loc4_] as TaskGoodItemView;
            _loc8_ = _goodsItemPointList[_loc4_] as Point;
            _loc2_.x = _loc8_.x;
            _loc2_.y = _loc8_.y;
            _loc2_.data = _loc5_;
            if(!_isRing)
            {
               continue;
            }
            if(_ringTask.ringTaskTemp.Type != 3)
            {
               continue;
            }
            _loc2_.txt = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardTitle0");
            switch(_loc4_)
            {
               case 0:
                  _loc2_.setgoodsCount(_loc5_.RewardItemCount,16);
                  break;
               case 1:
                  _loc2_.setgoodsCount(_loc5_.RewardItemCount,3);
                  break;
               case 2:
                  _loc2_.setgoodsCount(_loc5_.RewardItemCount,1);
            }
         }
         if(_isMarry)
         {
            _loc6_ = "50";
            _loc7_ = TempleteManager.instance.getConfigInfoByConfigName("mar_task_add_happy");
            if(_loc7_ && !StringHelper.isNullOrEmpty(_loc7_.ConfigValue))
            {
               _loc6_ = _loc7_.ConfigValue;
            }
            _marryTaskText.text = LanguageMgr.GetTranslation("task.view.TaskRewardViewII.allFinish.MarryTask",_loc6_);
            _vBox.addChild(_marryTaskText);
         }
      }
      
      private function getTaskGoodList(param1:Object) : Array
      {
         if(!param1)
         {
            return [];
         }
         var _loc4_:Array = param1.rewardItemList;
         var _loc2_:Array = [];
         if(param1 is TaskTemplate)
         {
            for each(var _loc5_:TaskGoodsTemplate in _loc4_)
            {
               if(_loc5_.TemplateId == param1.TemplateId && Boolean(_loc5_.fitJob(thane.templateInfo.Job)))
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         else if(param1 is OfferRewardTemplate)
         {
            if(_isRing)
            {
               if(_ringTask.ringTaskTemp.Type == 3)
               {
                  return RingTaskManager.instance.getAllRingTaskGoodsReward();
               }
               return RingTaskManager.instance.getRewardGoodsTemp(_ringTask);
            }
            for each(var _loc3_:OfferRewardGoodsTemplate in _loc4_)
            {
               if(_loc3_.TemplateId == param1.TemplateId)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         for each(var _loc2_:TaskGoodItemView in _goodsList)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         _goodsList = null;
         for each(var _loc1_:TaskRewardItem in _rewardItemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _rewardItemList = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_contain1);
         _contain1 = null;
         ObjectUtils.disposeObject(_contain2);
         _contain2 = null;
         _goodsItemPointList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

