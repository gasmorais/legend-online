package funny.view
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
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
   
   public class DoubleGiftItem extends Sprite implements Disposeable
   {
      
      private var _giftLable:FilterFrameText;
      
      private var _getBtn:IconButton;
      
      private var _hbox:HBox;
      
      private var _filters:UIFilter;
      
      private var _hasGet:Bitmap;
      
      private var _data:FunnyBagData;
      
      public function DoubleGiftItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _giftLable = ComponentFactory.Instance.creatComponentByStylename("funny.doubleBagItem.giftLable01");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.getBtn");
         _hbox = new HBox();
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         _filters = new UIFilter();
         addChild(_giftLable);
         _giftLable.text = "礼包A";
         addChild(_hbox);
         _hbox.x = 58;
         addChild(_getBtn);
         _getBtn.y = 9;
         addChild(_hasGet);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnHandler);
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         if(FunnyManager.instance.selectedFunnyData.endTime <= PlayerManager.instance.currentPlayerModel.nowDate)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc6_:MovieImage = null;
         var _loc5_:StarInfo = null;
         var _loc7_:StarBagCell = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         _getBtn.backStyle = "asset.core.Style24Btn";
         _getBtn.iconStyle = "asset.funny.getIcon";
         _getBtn.iconInnerRectString = "22,46,7,21,13";
         _loc3_ = 0;
         while(_loc3_ < _data.rewardList.length)
         {
            if(_data.rewardList[_loc3_].temType == 1)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _data.rewardList[_loc3_].temId;
               _loc4_.count = _data.rewardList[_loc3_].count;
               _loc4_.showCount = true;
               _loc4_.isBinds = _data.rewardList[_loc3_].isBind;
               _loc4_.strengthenGrade = _data.rewardList[_loc3_].strengthenGrade;
               _loc2_.data = _loc4_;
               if(filterEquip(_loc4_))
               {
                  addChild(_loc2_);
                  _loc2_.x = 78 + 64 * (_loc3_ % 5);
                  _loc2_.y = Math.floor(_loc3_ / 5) * 64 + 14;
                  _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.rewardList[_loc3_].temId);
                  if(_loc8_ && _loc8_.Profile >= 5)
                  {
                     _loc6_ = ComponentFactory.Instance.creatComponentByStylename("funny.LightEffect");
                     _loc6_.mouseEnabled = false;
                     _loc6_.mouseChildren = false;
                     _loc6_.x = _loc2_.x + 26;
                     _loc6_.y = _loc2_.y - 28;
                     addChild(_loc6_);
                  }
               }
            }
            else if(_data.rewardList[_loc3_].temType == 2)
            {
               _loc5_ = new StarInfo();
               _loc5_.template = TempleteManager.instance.starTempalteCate.getTemplateByID(_data.rewardList[_loc3_].temId);
               _loc5_.count = _data.rewardList[_loc3_].count;
               _loc5_.grade = _data.rewardList[_loc3_].strengthenGrade <= 0 ? 1 : _data.rewardList[_loc3_].strengthenGrade;
               if(filterStar(_loc5_))
               {
                  _loc7_ = ComponentFactory.Instance.creatCustomObject("funnyBagItem.StarBagCell");
                  _loc7_.data = _loc5_;
                  _loc7_.acceptDrop = false;
                  _loc7_.lock = false;
                  addChild(_loc7_);
                  _loc7_.x = 78 + 64 * (_loc3_ % 5);
                  _loc7_.y = Math.floor(_loc3_ / 5) * 64 + 14;
               }
            }
            _loc3_++;
         }
         setState(_data);
      }
      
      public function get realHeight() : int
      {
         return _data && _data.rewardList ? Math.ceil(_data.rewardList.length / 5) * 63 : 63;
      }
      
      public function set index(param1:int) : void
      {
         _giftLable.setFrame(param1 % 2 + 1);
         if(param1 % 2 == 0)
         {
            _giftLable.text = LanguageMgr.GetTranslation("funny.view.FunnyDoubleBagItem.giftLable01");
         }
         else
         {
            _giftLable.text = LanguageMgr.GetTranslation("funny.view.FunnyDoubleBagItem.giftLable02");
         }
      }
      
      public function setState(param1:FunnyBagData, param2:Boolean = false) : void
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
         }
      }
      
      private function filterEquip(param1:GoodsInfo) : Boolean
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
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_hbox);
         ObjectUtils.disposeObject(_hbox);
         ObjectUtils.disposeObject(_getBtn);
         ObjectUtils.disposeObject(_hasGet);
         ObjectUtils.disposeObject(_giftLable);
      }
   }
}

