package specialfunny.karneval
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import managers.FunnyManager;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class KarnevalBagItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _title:GradientText;
      
      private var _hBox:HBox;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _getImg:Bitmap;
      
      private var _data:FunnyBagData;
      
      public function KarnevalBagItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.onlinereward.KarnevalBagItemBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("KarnevalBagItem.title");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("KarnevalBagItem.hBox");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("KarnevalBagItem.getBtn");
         _getImg = ComponentFactory.Instance.creatBitmap("asset.onlinereward.KarnevalHasGet");
         addChild(_bg);
         addChild(_title);
         addChild(_hBox);
         addChild(_getImg);
         addChild(_getBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_getImg);
         _getImg = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            FunnyManager.instance.sendGetBag(4,_data.activeId,_data.id);
         }
      }
      
      private function setState() : void
      {
         if(_data == null)
         {
            return;
         }
         switch(int(_data.status) - 1)
         {
            case 0:
               if(_getImg)
               {
                  _getImg.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = true;
               }
               break;
            case 1:
               if(_getImg)
               {
                  _getImg.visible = true;
               }
               if(_getBtn)
               {
                  _getBtn.visible = false;
               }
               break;
            case 2:
               if(_getImg)
               {
                  _getImg.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
               }
         }
      }
      
      private function clean() : void
      {
         _title.text = "";
         _hBox.disposeAllChildren();
         _getImg.visible = false;
         _getBtn.visible = false;
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:StarInfo = null;
         var _loc6_:StarBagCell = null;
         _data = param1;
         clean();
         if(_data)
         {
            _title.text = _data.title;
            _title.x = _data.title.length > 35 ? 5 : 55;
            _loc3_ = 0;
            while(_loc3_ < _data.rewardList.length)
            {
               if(_data.rewardList[_loc3_].temType == 1)
               {
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("KarnevalBagItem.BaseItemView");
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _data.rewardList[_loc3_].temId;
                  _loc4_.count = _data.rewardList[_loc3_].count;
                  _loc4_.showCount = true;
                  _loc4_.isBinds = _data.rewardList[_loc3_].isBind;
                  _loc4_.strengthenGrade = _data.rewardList[_loc3_].strengthenGrade;
                  _loc2_.data = _loc4_;
                  if(filterEquip(_loc4_))
                  {
                     _hBox.addChild(_loc2_);
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
                     _loc6_ = ComponentFactory.Instance.creatCustomObject("KarnevalBagItem.StarBagCell");
                     _loc6_.data = _loc5_;
                     _loc6_.acceptDrop = false;
                     _loc6_.lock = false;
                     _hBox.addChild(_loc6_);
                  }
               }
               _loc3_++;
            }
            _hBox.refreshChildPos();
            setState();
         }
      }
      
      private function filterEquip(param1:GoodsInfo) : Boolean
      {
         var _loc2_:int = int(ThaneInfoHelper.getJob(ArmyManager.instance.thane.job));
         if(param1.templateInfo.Job == "0" || param1.templateInfo.Job == _loc2_ + "" || param1.templateInfo.Job == "99")
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
         var _loc2_:int = int(ThaneInfoHelper.getJob(ArmyManager.instance.thane.job));
         if(param1.template.Job.indexOf(_loc2_ + "") >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

