// GENERATED BY genfields.pl. DO NOT EDIT!
package vrml.field;
import vrml.*;
import java.util.*;

public class SFFloat extends Field {
float v;
public SFFloat() { v = 0;}
public SFFloat(float val) { v=val;}
public void setValue(float val) {v=val; value_touched();}
public SFFloat(String s) throws Exception {
		;
		if(s == null) {
			v = 0;; return;
		}
		s = s.trim();
		
	s = s.trim();
	v = new Float(s).floatValue();

	}public float getValue() {return v;}
public void setValue(ConstSFFloat f) {v = f.getValue(); value_touched();}
		public void setValue(SFFloat f) {v = f.getValue(); value_touched(); }
public String toString() {return new Float(v).toString();}public Object clone() {SFFloat _x = new SFFloat(v); return _x;}}