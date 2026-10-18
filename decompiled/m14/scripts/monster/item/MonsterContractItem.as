package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import monster.view.MonsterContractSelectView;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterContractItem extends Component
   {
      
      private var _back:Image;
      
      private var _monsterIcon:BaseIconView;
      
      private var _overImage:Image;
      
      private var _alertImage:Image;
      
      private var _delBtn:BaseButton;
      
      private var _starHbox:HBox;
      
      private var _descText:FilterFrameText;
      
      private var index:int;
      
      private var _data:MonsterInfo;
      
      private var preStar:int;
      
      private var _continer:Component;
      
      private var _selectMonsterView:MonsterContractSelectView;
      
      public function MonsterContractItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterContractItem.back");
         _monsterIcon = ComponentFactory.Instance.creatCustomObject("MonsterContractItem.monsterIcon");
         _overImage = ComponentFactory.Instance.creatComponentByStylename("MonsterContractItem.overImage");
         _alertImage = ComponentFactory.Instance.creatComponentByStylename("MonsterContractItem.alertImage");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterContractItem.delBtn");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterContractItem.starHbox");
         _descText = ComponentFactory.Instance.creatComponentByStylename("MonsterContractItem.descText");
         _continer = new Component();
         addChild(_continer);
         addChild(_alertImage);
         addChild(_delBtn);
         addChild(_starHbox);
         addChild(_descText);
         _continer.addChild(_back);
         _continer.addChild(_monsterIcon);
         _continer.addChild(_overImage);
         _alertImage.tipData = LanguageMgr.GetTranslation("MonsterContractItem.alertImage.tipdata");
         _overImage.visible = false;
         _continer.buttonMode = true;
         _overImage.mouseChildren = _overImage.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _continer.addEventListener("mouseOver",__onOverHandler);
         _continer.addEventListener("mouseOut",__onOutHandler);
         _continer.addEventListener("click",__clickHandler);
         _delBtn.addEventListener("click",__delClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_continer)
         {
            _continer.removeEventListener("mouseOver",__onOverHandler);
         }
         if(_continer)
         {
            _continer.removeEventListener("mouseOut",__onOutHandler);
         }
         if(_continer)
         {
            _continer.removeEventListener("click",__clickHandler);
         }
         if(_delBtn)
         {
            _delBtn.removeEventListener("click",__delClickHandler);
         }
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         _overImage.visible = true;
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         _overImage.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Array = null;
         var _loc2_:Point = null;
         if(model.monsterDic.getList().length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterFormation.noMonsterSelect"));
            return;
         }
         if(!_selectMonsterView)
         {
            _loc3_ = model.getContractSelectList();
            _selectMonsterView = new MonsterContractSelectView();
            _selectMonsterView.show(_loc3_,index);
            _selectMonsterView.addEventListener("dispose",__disposeSelectView);
            _loc2_ = new Point(_continer.displayWidth / 2,0);
            _loc2_ = this.localToGlobal(_loc2_);
            _selectMonsterView.x = _loc2_.x + 50;
            _selectMonsterView.y = _loc2_.y + 55;
         }
      }
      
      private function __disposeSelectView(param1:Event) : void
      {
         _selectMonsterView.removeEventListener("dispose",__disposeSelectView);
         _selectMonsterView = null;
      }
      
      private function __delClickHandler(param1:MouseEvent) : void
      {
         MonsterManager.instance.sendSelectContract(index,0);
      }
      
      public function get data() : MonsterInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         var _loc4_:GoodsInfo = null;
         _data = param1;
         if(data)
         {
            _monsterIcon.icon = IconFactory.getCommonIconPath(data.tempInfo.Icon);
            _monsterIcon.tipData = data;
            _delBtn.visible = true;
            if(preStar != data.star)
            {
               _starHbox.removeAllChild();
               _loc3_ = 0;
               while(_loc3_ < data.star)
               {
                  _loc2_ = ComponentFactory.Instance.creatBitmap("asset.MonsterPropView.starBitmap");
                  _starHbox.addChild(_loc2_);
                  _loc3_++;
               }
            }
            preStar = data.star;
            _loc4_ = GoodsManager.instance.getMonsterBagGoodsInfo(data.monsterId);
            if(_loc4_)
            {
               _descText.text = getDescText(_loc4_);
               _alertImage.visible = model.isShowContractAlert(index);
            }
            else
            {
               _descText.text = LanguageMgr.GetTranslation("MonsterContractItem.descText.text");
               _alertImage.visible = false;
            }
         }
         else
         {
            preStar = -1;
            _starHbox.removeAllChild();
            _descText.text = "";
            _delBtn.visible = false;
            _alertImage.visible = false;
            _monsterIcon.icon = null;
            _monsterIcon.tipData = null;
         }
      }
      
      private function getDescText(param1:GoodsInfo) : String
      {
         var _loc2_:int = int(model.getEffectSonType(param1));
         if(_loc2_ == 0)
         {
            return LanguageMgr.GetTranslation("MonsterAccessoriesTipsContent.effectTxt.text");
         }
         var _loc3_:Array = model.getEffectGradeAry(param1);
         return model.getEffectTxt(_loc2_,_loc3_);
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_continer);
         _continer = null;
         ObjectUtils.disposeObject(_monsterIcon);
         _monsterIcon = null;
         ObjectUtils.disposeObject(_overImage);
         _overImage = null;
         ObjectUtils.disposeObject(_alertImage);
         _alertImage = null;
         ObjectUtils.disposeObject(_delBtn);
         _delBtn = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_selectMonsterView);
         _selectMonsterView = null;
         super.dispose();
      }
   }
}

