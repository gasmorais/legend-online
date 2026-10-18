package newmemorycard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NewMemoryCardManager;
   import mvc.module.newmemorycard.NewMemoryCardModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class NewMemoryCardItem extends Component
   {
      
      private var _mc:MovieClip;
      
      private var _selectedBg:Bitmap;
      
      private var _item:BaseItemView;
      
      private var _index:int;
      
      private var _iconEffect:MovieClip;
      
      private var _borderEffect:MovieClip;
      
      private var _lightEffect:MovieClip;
      
      private var _data:GoodsInfo;
      
      public function NewMemoryCardItem(param1:int)
      {
         _index = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("asset.newmemoryitem.ItemEffect");
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.newmemoryitem.selectedBg");
         _item = ComponentFactory.Instance.creatCustomObject("newmemoryitem.item");
         _iconEffect = ComponentFactory.Instance.creatCustomObject("asset.newmemoryitem.iconEffect");
         _borderEffect = ComponentFactory.Instance.creatCustomObject("asset.newmemoryitem.borderEffect");
         _lightEffect = ComponentFactory.Instance.creatCustomObject("asset.newmemoryitem.lightEffect");
         addChild(_lightEffect);
         addChild(_mc);
         addChild(_selectedBg);
         addChild(_iconEffect);
         addChild(_borderEffect);
         reset();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(model.step <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("NewMemoryCardItem.step.txt"));
            return;
         }
         if(!model.lock)
         {
            if(model.clickIndexArr.length == 1 && model.clickIndexArr[0] == _index)
            {
               _selectedBg.visible = false;
               model.clickIndexArr = [];
               return;
            }
            model.clickIndexArr.push(_index);
            _selectedBg.visible = true;
            if(model.clickIndexArr.length >= 2)
            {
               model.lock = true;
               NewMemoryCardManager.instance.sendChoose();
            }
         }
      }
      
      public function play() : void
      {
         _selectedBg.visible = false;
         _mc.gotoAndPlay(1);
         _mc.addFrameScript(7,setData);
         _mc.addFrameScript(15,gotoAndPlay);
         _mc.addFrameScript(60,setData);
         _mc.addFrameScript(39,clearEffect);
         _mc.addFrameScript(84,clearEffect);
         _mc.addFrameScript(59,stop);
         _mc.addFrameScript(94,over);
      }
      
      public function reset() : void
      {
         var _loc3_:Array = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         _selectedBg.visible = false;
         clearEffect();
         stop();
         if(model.posInfo != "")
         {
            _loc3_ = model.posInfo.split(",");
            _loc1_ = false;
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               if(_loc3_[_loc2_] == _index)
               {
                  _loc1_ = true;
                  break;
               }
               _loc2_++;
            }
         }
         isOver(_loc1_);
         _data = null;
      }
      
      private function setData() : void
      {
         var _loc3_:Array = null;
         var _loc2_:Array = null;
         if(!_data)
         {
            _loc3_ = model.result.split("|");
            for each(var _loc1_:String in _loc3_)
            {
               _loc2_ = _loc1_.split(",");
               if(_loc2_[0] == _index)
               {
                  _data = new GoodsInfo();
                  _data.templateId = _loc2_[1];
                  _data.count = _loc2_[2];
                  break;
               }
            }
         }
         _item.data = _data;
         _mc["content"]["icon"].addChild(_item);
      }
      
      private function gotoAndPlay() : void
      {
         if(model.isMatch)
         {
            _mc.gotoAndPlay(61);
         }
         var _loc1_:Array = model.specialInfo.split(",");
         if(_data.templateId == _loc1_[0])
         {
            playEffect();
         }
         else
         {
            clearEffect();
         }
      }
      
      private function playEffect() : void
      {
         _iconEffect.visible = true;
         _iconEffect.gotoAndPlay(1);
         _borderEffect.visible = true;
         _borderEffect.gotoAndPlay(1);
         _lightEffect.visible = true;
         _lightEffect.gotoAndPlay(1);
      }
      
      private function clearEffect() : void
      {
         _iconEffect.gotoAndStop(1);
         _iconEffect.visible = false;
         _borderEffect.gotoAndStop(1);
         _borderEffect.visible = false;
         _lightEffect.gotoAndStop(1);
         _lightEffect.visible = false;
      }
      
      private function stop() : void
      {
         model.clickIndexArr = [];
         model.lock = false;
         _mc.stop();
      }
      
      private function over() : void
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         stop();
         isOver(true);
         var _loc2_:Array = model.posInfo.split(",");
         if(_loc2_.length >= 24)
         {
            if(_loc2_[23] == _index)
            {
               SimpleAlertHelper.instance.data = [callBack];
               _loc1_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("NewMemoryCardItem.content.txt");
               SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,"",true,true);
            }
         }
      }
      
      private function callBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            NewMemoryCardManager.instance.send(4);
         }
      }
      
      private function isOver(param1:Boolean) : void
      {
         if(param1)
         {
            _mc.gotoAndStop(95);
            this.buttonMode = this.mouseChildren = this.mouseEnabled = false;
            removeEvent();
         }
         else
         {
            _mc.gotoAndStop(1);
            this.buttonMode = this.mouseChildren = this.mouseEnabled = true;
            initEvent();
         }
      }
      
      public function get model() : NewMemoryCardModel
      {
         return NewMemoryCardManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeViolentMc(_iconEffect);
         _iconEffect = null;
         ObjectUtils.disposeViolentMc(_borderEffect);
         _borderEffect = null;
         ObjectUtils.disposeViolentMc(_lightEffect);
         _lightEffect = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

