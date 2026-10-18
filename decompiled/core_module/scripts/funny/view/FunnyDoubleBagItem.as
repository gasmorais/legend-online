package funny.view
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.FunnyHelper;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyRewardData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class FunnyDoubleBagItem extends Sprite implements Disposeable
   {
      
      private var _title:FilterFrameText;
      
      private var _rewardList:SimpleTileList;
      
      private var _hasGet:Bitmap;
      
      private var _getBtn:IconButton;
      
      private var _data:Array;
      
      private var _filters:UIFilter;
      
      private var _realHeight:int = 14;
      
      public function FunnyDoubleBagItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.title");
         _rewardList = ComponentFactory.Instance.creatCustomObject("funnyRewardItem.rewardTileList");
         _filters = new UIFilter();
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.getBtn");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         addChild(_title);
         addChild(_rewardList);
         addChild(_getBtn);
         addChild(_hasGet);
      }
      
      public function set data(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DoubleGiftItem = null;
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         if(_data.length <= 1)
         {
            setBagData(_data[0]);
            _title.text = (_data[0] as FunnyBagData).title;
         }
         else
         {
            _getBtn.visible = false;
            _hasGet.visible = false;
            _rewardList.visible = false;
            _loc3_ = 0;
            while(_loc3_ < _data.length)
            {
               _loc2_ = new DoubleGiftItem();
               _loc2_.data = _data[_loc3_];
               addChild(_loc2_);
               _loc2_.index = _loc3_;
               _loc2_.y = _realHeight;
               _realHeight = _loc2_.realHeight + _loc2_.y;
               _loc3_++;
            }
            _title.text = (_data[0] as FunnyBagData).title + LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title20_1");
         }
         _title.height = _title.numLines > 1 ? 45 : 20;
         _rewardList.y = _title.numLines > 1 ? 38 : 21;
         setFilter();
      }
      
      private function setBagData(param1:FunnyBagData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc6_:MovieImage = null;
         var _loc5_:StarInfo = null;
         var _loc7_:StarBagCell = null;
         _rewardList.disposeAllChildren();
         _rewardList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1.rewardList.length)
         {
            if(param1.rewardList[_loc3_].temType == 1)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = param1.rewardList[_loc3_].temId;
               _loc4_.count = param1.rewardList[_loc3_].count;
               _loc4_.showCount = true;
               _loc4_.isBinds = param1.rewardList[_loc3_].isBind;
               _loc4_.strengthenGrade = param1.rewardList[_loc3_].strengthenGrade;
               _loc2_.data = _loc4_;
               if(filterEquip(_loc4_))
               {
                  _rewardList.addChild(_loc2_);
                  _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.rewardList[_loc3_].temId);
                  if(_loc8_ && _loc8_.Profile >= 5)
                  {
                     _loc6_ = ComponentFactory.Instance.creatComponentByStylename("funny.LightEffect");
                     _loc6_.mouseEnabled = false;
                     _loc6_.mouseChildren = false;
                     _loc6_.x = _loc2_.x + 26;
                     _loc6_.y = _loc2_.y - 8;
                     addChild(_loc6_);
                  }
               }
            }
            else if(param1.rewardList[_loc3_].temType == 2)
            {
               _loc5_ = new StarInfo();
               _loc5_.template = TempleteManager.instance.starTempalteCate.getTemplateByID(param1.rewardList[_loc3_].temId);
               _loc5_.count = param1.rewardList[_loc3_].count;
               _loc5_.grade = param1.rewardList[_loc3_].strengthenGrade <= 0 ? 1 : param1.rewardList[_loc3_].strengthenGrade;
               if(filterStar(_loc5_))
               {
                  _loc7_ = ComponentFactory.Instance.creatCustomObject("funnyBagItem.StarBagCell");
                  _loc7_.data = _loc5_;
                  _loc7_.acceptDrop = false;
                  _loc7_.lock = false;
                  _rewardList.addChild(_loc7_);
               }
            }
            _loc3_++;
         }
         _rewardList.column = 6;
         _rewardList.commitChanges();
         _realHeight = _rewardList.y + _rewardList.height;
         setState(param1);
      }
      
      public function setState(param1:FunnyBagData) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.status - 1)
         {
            case 0:
               _filters.setNormalFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = true;
               }
               if(_title)
               {
                  _title.setFrame(2);
               }
               break;
            case 1:
               if(_hasGet)
               {
                  _hasGet.visible = true;
               }
               if(_getBtn)
               {
                  _getBtn.visible = false;
               }
               if(_title)
               {
                  _title.setFrame(1);
               }
               break;
            case 2:
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
               }
               if(_title)
               {
                  _title.setFrame(2);
               }
         }
      }
      
      private function setFilter() : void
      {
         if(_data.length > 1)
         {
            if(_data[0].status == 2 || _data[1].status == 2)
            {
               _filters.setGrayFilter(this);
               _title.setFrame(1);
            }
            else
            {
               _filters.setNormalFilter(this);
               _title.setFrame(2);
            }
         }
         else if(_data[0].status == 2)
         {
            _filters.setGrayFilter(this);
         }
         else
         {
            _filters.setNormalFilter(this);
         }
      }
      
      public function filterEquip(param1:GoodsInfo) : Boolean
      {
         var _loc2_:int = thane.templateInfo.Job;
         if(param1.templateInfo.Job == "0" || param1.templateInfo.Job == "4" || param1.templateInfo.Job == _loc2_ + "" || param1.templateInfo.Job == "99")
         {
            return true;
         }
         return false;
      }
      
      private function filterStar(param1:StarInfo) : Boolean
      {
         if(!param1 || !param1.template)
         {
            return false;
         }
         if(param1.template.Job.indexOf("0") >= 0)
         {
            return true;
         }
         switch(thane.job - 1)
         {
            case 0:
            case 3:
               if(param1.template.Job.indexOf("1") >= 0)
               {
                  return true;
               }
               return false;
               break;
            case 1:
            case 4:
               if(param1.template.Job.indexOf("2") >= 0)
               {
                  return true;
               }
               return false;
               break;
            case 2:
            case 5:
               if(param1.template.Job.indexOf("3") >= 0)
               {
                  return true;
               }
               return false;
               break;
            default:
               return false;
         }
      }
      
      private function hasFashion(param1:FunnyBagData) : Boolean
      {
         var _loc3_:GoodsInfo = null;
         if(!param1 || param1.rewardList.length <= 0)
         {
            return false;
         }
         for each(var _loc2_:FunnyRewardData in param1.rewardList)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.temId;
            _loc3_.count = _loc2_.count;
            _loc3_.isBinds = _loc2_.isBind;
            _loc3_.strengthenGrade = _loc2_.strengthenGrade <= 0 ? 1 : _loc2_.strengthenGrade;
            if(fashionModel.isFashion(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnHandler);
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:FunnyMutiFrame = null;
         if(FunnyManager.instance.selectedFunnyData.endTime <= PlayerManager.instance.currentPlayerModel.nowDate)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         if(FunnyHelper.isMutConditionType(_data[0]) && FunnyManager.instance.selectedFunnyData.getWay == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("funny.view.FunnyMutiFrame");
            _loc2_.data = _data[0];
            _loc2_.show();
         }
         else
         {
            FunnyManager.instance.sendGetBag(2,_data[0].activeId,_data[0].id);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function get height() : Number
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         return _realHeight;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_rewardList);
         _rewardList = null;
         ObjectUtils.disposeObject(_hasGet);
         _hasGet = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
      }
   }
}

