package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.Shape;
   import flash.display.Sprite;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.events.RoleEvent;
   import yishi.filter.UIFilter;
   
   public class TeamStrip extends Sprite implements Disposeable
   {
      
      private var _backTxt:GradientText;
      
      private var _iconTxt:GradientText;
      
      private var _mask:Shape;
      
      private var _info:HeroRoleInfo;
      
      private var _side:int;
      
      public function TeamStrip(param1:HeroRoleInfo, param2:int)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         _info = param1;
         _side = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         if(_side == 1)
         {
            _backTxt = ComponentFactory.Instance.creatComponentByStylename("battle.teamStripText1");
            _iconTxt = ComponentFactory.Instance.creatComponentByStylename("battle.teamStripText1");
         }
         else if(_side == 2)
         {
            _backTxt = ComponentFactory.Instance.creatComponentByStylename("battle.teamStripText2");
            _iconTxt = ComponentFactory.Instance.creatComponentByStylename("battle.teamStripText2");
         }
         _backTxt.filters = [UIFilter.getGrayFilter()];
         addChild(_backTxt);
         addChild(_iconTxt);
         _backTxt.text = _info.heroInfo.nickName;
         _iconTxt.text = _info.heroInfo.nickName;
         initMask();
         refreshView();
      }
      
      private function initMask() : void
      {
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_iconTxt.textWidth,_iconTxt.height);
         _mask.graphics.endFill();
         if(_side == 1)
         {
            _mask.x = 2;
         }
         else if(_side == 2)
         {
            _mask.x = _iconTxt.width - _iconTxt.textWidth - 3;
         }
         _iconTxt.mask = _mask;
         addChild(_mask);
      }
      
      private function refreshView() : void
      {
         if(_mask == null || _info == null || _iconTxt == null)
         {
            return;
         }
         _mask.width = _iconTxt.textWidth * (_info.bloodA / _info.totalBloodA);
      }
      
      private function initEvent() : void
      {
         _info.addEventListener("bloodChange",__bloodChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_info)
         {
            _info.removeEventListener("bloodChange",__bloodChangeHandler);
         }
      }
      
      private function __bloodChangeHandler(param1:RoleEvent) : void
      {
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_backTxt)
         {
            _backTxt.filters = null;
            _backTxt.dispose();
         }
         _backTxt = null;
         if(_iconTxt)
         {
            _iconTxt.mask = null;
            _iconTxt.dispose();
         }
         _iconTxt = null;
         if(_mask)
         {
            _mask.graphics.clear();
            if(_mask.parent)
            {
               _mask.parent.removeChild(_mask);
            }
         }
         _mask = null;
         if(_info)
         {
            _info.dispose();
         }
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

